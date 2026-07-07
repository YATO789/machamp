# データベース設計

## エンティティ


## テーブル

body_parts
```sql
CREATE TABLE body_parts (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text NOT NULL UNIQUE,  -- English: 'chest', 'legs', 'back', 'shoulders', 'arms', 'abs'
  sort_order  integer NOT NULL, -- 表示順を管理するためのカラム
  created_at  timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX body_parts_sort_order_unique
ON body_parts(sort_order);
```

exercise_body_parts
- body_partsが複数ある場合に対応
```sql
CREATE TABLE exercise_body_parts (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  exercise_id  uuid NOT NULL REFERENCES exercises(id) ON DELETE CASCADE,
  body_part_id uuid NOT NULL REFERENCES body_parts(id) ON DELETE RESTRICT,
  created_at   timestamptz NOT NULL DEFAULT now(),
  UNIQUE (exercise_id, body_part_id)
);

CREATE INDEX idx_exercise_body_parts_exercise_id
ON exercise_body_parts(exercise_id);

CREATE INDEX idx_exercise_body_parts_body_part_id
ON exercise_body_parts(body_part_id);

```

equipments
```sql
CREATE TABLE equipments (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text NOT NULL UNIQUE,  -- English: 'barbell', 'dumbbell', 'machine', 'bodyweight', 'cable'
  sort_order  integer NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX body_parts_sort_order_unique
ON equipments(sort_order);
```

exercises
```sql
CREATE TABLE exercises (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name         text NOT NULL,
  equipment_id uuid NOT NULL REFERENCES equipments(id) ON DELETE RESTRICT,
  user_id      uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at   timestamptz NOT NULL DEFAULT now(),
  updated_at   timestamptz NOT NULL DEFAULT now()
);

-- 「同じユーザーが同じ名前の種目を2つ作れないようにする(ユーザー作成の種目のみ)」
CREATE UNIQUE INDEX exercises_user_name_unique
ON exercises(user_id, name)
WHERE user_id IS NOT NULL;

CREATE INDEX idx_exercises_equipment_id
ON exercises(equipment_id);

CREATE INDEX idx_exercises_user_id
ON exercises(user_id);

CREATE UNIQUE INDEX exercises_global_name_unique
ON exercises(name)
WHERE user_id IS NULL;
```

menus
```sql
CREATE TABLE menus (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name        text NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now(),
  updated_at  timestamptz NOT NULL DEFAULT now(),

  UNIQUE (user_id, name)
);

CREATE INDEX idx_menus_user_id
ON menus(user_id);
```

menu_exercises
```sql
CREATE TABLE menu_exercises (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  menu_id         uuid NOT NULL REFERENCES menus(id) ON DELETE CASCADE,
  exercise_id     uuid NOT NULL REFERENCES exercises(id) ON DELETE RESTRICT,
  exercise_order  integer NOT NULL CHECK (exercise_order > 0),
  created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX menu_exercises_order_unique
ON menu_exercises(menu_id, exercise_order);

CREATE INDEX idx_menu_exercises_menu_id
ON menu_exercises(menu_id);

CREATE INDEX idx_menu_exercises_exercise_id
ON menu_exercises(exercise_id);
```

exercise_sets
```sql
CREATE TABLE exercise_sets (
  id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  menu_exercise_id  uuid NOT NULL REFERENCES menu_exercises(id) ON DELETE CASCADE,
  set_order         integer NOT NULL CHECK (set_order > 0),
  reps              integer NOT NULL DEFAULT 10 CHECK (reps > 0),
  weight            numeric(6,2) NOT NULL DEFAULT 0 CHECK (weight >= 0),
  created_at        timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX exercise_sets_order_unique
ON exercise_sets(menu_exercise_id, set_order);

CREATE INDEX idx_exercise_sets_menu_exercise_id
ON exercise_sets(menu_exercise_id);
```

---
workout_sessions
```sql
CREATE TABLE workout_sessions (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  menu_id     uuid REFERENCES menus(id) ON DELETE SET NULL,
  menu_name   text, -- ★追加: 当時のメニュー名を保存するログ用カラム
  status      text NOT NULL DEFAULT 'in_progress'
                CHECK (status IN ('in_progress', 'completed', 'cancelled')),
  started_at  timestamptz NOT NULL DEFAULT now(),
  finished_at timestamptz, 
  created_at  timestamptz NOT NULL DEFAULT now(),

  CHECK (
    finished_at IS NULL
    OR finished_at >= started_at
  )
);

CREATE INDEX idx_workout_sessions_user_id
ON workout_sessions(user_id);

CREATE INDEX idx_workout_sessions_menu_id
ON workout_sessions(menu_id);

CREATE INDEX idx_workout_sessions_user_started
ON workout_sessions(user_id, started_at DESC);

```

workout_exercises
```sql
CREATE TABLE workout_exercises (
  id                  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  workout_session_id  uuid NOT NULL REFERENCES workout_sessions(id) ON DELETE CASCADE,
  exercise_id         uuid NOT NULL REFERENCES exercises(id) ON DELETE RESTRICT,
  exercise_order      integer NOT NULL CHECK (exercise_order > 0),
  created_at          timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX workout_exercises_order_unique
ON workout_exercises(workout_session_id, exercise_order);

CREATE INDEX idx_workout_exercises_workout_session_id
ON workout_exercises(workout_session_id);

CREATE INDEX idx_workout_exercises_exercise_id
ON workout_exercises(exercise_id);
```

workout_set
```sql
CREATE TABLE workout_sets (
  id                   uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  workout_exercise_id  uuid NOT NULL REFERENCES workout_exercises(id) ON DELETE CASCADE,
  set_order            integer NOT NULL CHECK (set_order > 0),
  reps                 integer NOT NULL CHECK (reps > 0),
  weight               numeric(6,2) NOT NULL CHECK (weight >= 0),
  created_at           timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX workout_sets_order_unique
ON workout_sets(workout_exercise_id, set_order);

CREATE INDEX idx_workout_sets_workout_exercise_id
ON workout_sets(workout_exercise_id);
```

```sql
-- （例）更新用関数の作成
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';


-- （例）テーブルへの適用
CREATE TRIGGER update_menus_updated_at
BEFORE UPDATE ON menus
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

```

workout_sessions レコードが「作成（INSERT）」または「更新（UPDATE）」された際、menu_id がセットされていれば menus テーブルから自動で名前を引いてきて menu_name に代入する仕組みを定義し

```sql
-- ① 自動コピーを行う関数（プロシージャ）の定義
CREATE OR REPLACE FUNCTION set_workout_session_menu_name()
RETURNS TRIGGER AS $$
BEGIN
  -- menu_id が新しく設定された、または変更された場合
  IF NEW.menu_id IS NOT NULL AND (TG_OP = 'INSERT' OR OLD.menu_id IS NULL OR NEW.menu_id <> OLD.menu_id) THEN
    -- menus テーブルから当時の名前を取得して代入
    SELECT name INTO NEW.menu_name FROM menus WHERE id = NEW.menu_id;
  
  -- もし menu_id が NULL にクリアされた場合は、menu_name はそのまま（過去のログとして残す）
  -- ただし、最初から menu_id なしで登録された場合は NULL のままにする
  ELSIF NEW.menu_id IS NULL AND TG_OP = 'INSERT' THEN
    NEW.menu_name := NULL;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ② トリガーをテーブルに紐づけ（レコード保存の直前に実行）
CREATE TRIGGER trigger_set_workout_session_menu_name
BEFORE INSERT OR UPDATE ON workout_sessions
FOR EACH ROW
EXECUTE FUNCTION set_workout_session_menu_name();
```

---

## シードデータ

```sql
INSERT INTO body_parts (name, sort_order) VALUES
  ('legs',      1),
  ('chest',     2),
  ('back',      3),
  ('shoulders', 4),
  ('arms',      5),
  ('abs',       6);

INSERT INTO equipments (name, sort_order) VALUES
  ('barbell',    1),
  ('dumbbell',   2),
  ('machine',    3),
  ('bodyweight', 4),
  ('cable',      5);
```

---

## ER図
```
body_parts ──┐
             ├── exercise_body_parts
equipments ──┤
             └── exercises ── auth.users
                    │
├── menus           │
│    │              │
│    └── menu_exercises
│          │
│          └── exercise_sets
│
└── workout_sessions
      │
      └── workout_exercises
            │
            └── workout_sets
```

```
auth.users
│
├── exercises ──── equipments (FK)
│    │
│    └── exercise_body_parts ──── body_parts
│
├── menus
│    │
│    └── menu_exercises
│          │
│          └── exercise_sets
│
└── workout_sessions
      │
      └── workout_exercises
            │
            └── workout_sets
```

- メニューと実際の記録を分離する
- body_parts・equipments はシステム固定のマスターテーブル（user_id なし）
- 1種目に複数の body_part を紐づけられる（exercise_body_parts で多対多）
- equipment は1種目につき1つ（exercises.equipment_id で単一FK）