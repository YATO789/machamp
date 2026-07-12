# データベース設計

## エンティティ
- body_parts
- equipments : 機材

- exercises
- exercise_body_parts

- menus : メニュー詳細
- menu_exercises
- menu_exercise_sets

- workout_sessions
- workout_exercise_sets
- workout_exercises


## テーブル
```sql

-- body_parts
CREATE TABLE body_parts (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text NOT NULL UNIQUE,  -- English: 'chest', 'legs', 'back', 'shoulders', 'arms', 'abs'
  sort_order  integer NOT NULL UNIQUE, -- 表示順を管理するためのカラム
  created_at  timestamptz NOT NULL DEFAULT now()
);


-- equipments
CREATE TABLE equipments (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text NOT NULL UNIQUE,  -- English: 'barbell', 'dumbbell', 'machine', 'bodyweight', 'cable'
  sort_order  integer NOT NULL UNIQUE,
  created_at  timestamptz NOT NULL DEFAULT now()
);


-- exercises

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

-- デフォルト種目名の重複を防ぐ
CREATE UNIQUE INDEX exercises_global_name_unique
ON exercises(name)
WHERE user_id IS NULL;

CREATE INDEX idx_exercises_equipment_id
ON exercises(equipment_id);

CREATE INDEX idx_exercises_user_id
ON exercises(user_id);


-- exercise_body_parts
-- exercises と body_parts の多対多の関係を表す中間テーブル
-- 1つの種目 ←→ 複数の部位  1つの部位 ←→ 複数の種目 の関係になっている
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


-- menus
CREATE TABLE menus (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name        text NOT NULL,
  is_public   boolean NOT NULL DEFAULT false,
  created_at  timestamptz NOT NULL DEFAULT now(),
  updated_at  timestamptz NOT NULL DEFAULT now(),

  UNIQUE (user_id, name)
);

CREATE INDEX idx_menus_user_id ON menus(user_id);

-- レコード(menus)が更新されたら updated_at を自動で現在時刻に更新するトリガー
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_menus_updated_at
BEFORE UPDATE ON menus
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();


-- menu_exercises
CREATE TABLE menu_exercises (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  menu_id         uuid NOT NULL REFERENCES menus(id) ON DELETE CASCADE,
  exercise_id     uuid NOT NULL REFERENCES exercises(id) ON DELETE RESTRICT,
  exercise_order  integer NOT NULL CHECK (exercise_order > 0),
  created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX menu_exercises_order_unique
ON menu_exercises(menu_id, exercise_order);

CREATE INDEX idx_menu_exercises_menu_id ON menu_exercises(menu_id);

CREATE INDEX idx_menu_exercises_exercise_id ON menu_exercises(exercise_id);


-- menu_exercise_sets
CREATE TABLE menu_exercise_sets (
  id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  menu_exercise_id  uuid NOT NULL REFERENCES menu_exercises(id) ON DELETE CASCADE,
  set_order         integer NOT NULL CHECK (set_order > 0),
  reps              integer NOT NULL DEFAULT 10 CHECK (reps > 0),
  weight            numeric(6,2) NOT NULL DEFAULT 0 CHECK (weight >= 0),
  created_at        timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX exercise_sets_order_unique ON menu_exercise_sets(menu_exercise_id, set_order);

CREATE INDEX idx_exercise_sets_menu_exercise_id ON menu_exercise_sets(menu_exercise_id);

-- workout_sessions
CREATE TABLE workout_sessions (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  menu_id     uuid REFERENCES menus(id) ON DELETE SET NULL,
  menu_name   text, -- メニューが消された時用に名前を保持
  status      text NOT NULL DEFAULT 'in_progress' CHECK (status IN ('in_progress', 'completed', 'cancelled')),
  started_at  timestamptz NOT NULL DEFAULT now(),
  finished_at timestamptz, 
  created_at  timestamptz NOT NULL DEFAULT now(),

  CHECK (finished_at IS NULL OR finished_at >= started_at)
);

CREATE INDEX idx_workout_sessions_user_id ON workout_sessions(user_id);

CREATE INDEX idx_workout_sessions_menu_id ON workout_sessions(menu_id);

-- トレーニング履歴を新しい順で表示を高速化
CREATE INDEX idx_workout_sessions_user_started ON workout_sessions(user_id, started_at DESC);

-- workout_sessions に保存される menu_name を、menu_id をもとに自動でコピーする
CREATE OR REPLACE FUNCTION set_workout_session_menu_name()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    IF NEW.menu_id IS NOT NULL THEN
      SELECT name INTO NEW.menu_name FROM menus WHERE id = NEW.menu_id;
    END IF;
    -- menu_id が NULL の場合はデフォルトで NULL になるため何もしなくてOK

  ELSIF TG_OP = 'UPDATE' THEN
    IF NEW.menu_id IS NOT NULL AND (OLD.menu_id IS NULL OR NEW.menu_id <> OLD.menu_id) THEN
      SELECT name INTO NEW.menu_name FROM menus WHERE id = NEW.menu_id;
    END IF;
    -- menu_id が NULL に更新された場合は、menu_name をそのまま維持（ログとして残す）
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_workout_session_menu_name
BEFORE INSERT OR UPDATE ON workout_sessions
FOR EACH ROW
EXECUTE FUNCTION set_workout_session_menu_name();


-- workout_exercises
CREATE TABLE workout_exercises (
  id                  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  workout_session_id  uuid NOT NULL REFERENCES workout_sessions(id) ON DELETE CASCADE,
  exercise_id         uuid NOT NULL REFERENCES exercises(id) ON DELETE RESTRICT,
  exercise_order      integer NOT NULL CHECK (exercise_order > 0),
  created_at          timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX workout_exercises_order_unique ON workout_exercises(workout_session_id, exercise_order);

CREATE INDEX idx_workout_exercises_workout_session_id ON workout_exercises(workout_session_id);

CREATE INDEX idx_workout_exercises_exercise_id ON workout_exercises(exercise_id);


-- workout_exercise_sets
CREATE TABLE workout_sets (
  id                   uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  workout_exercise_id  uuid NOT NULL REFERENCES workout_exercises(id) ON DELETE CASCADE,
  set_order            integer NOT NULL CHECK (set_order > 0),
  reps                 integer NOT NULL CHECK (reps > 0),
  weight               numeric(6,2) NOT NULL CHECK (weight >= 0),
  created_at           timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX workout_sets_order_unique ON workout_sets(workout_exercise_id, set_order);

CREATE INDEX idx_workout_sets_workout_exercise_id ON workout_sets(workout_exercise_id);
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
│          └── menu_exercise_sets
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
│          └── menu_exercise_sets
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

---

## RLS（Row Level Security）

### 方針まとめ

| テーブル | SELECT | INSERT | UPDATE | DELETE |
|---|---|---|---|---|
| `body_parts` / `equipments` | authenticated 全員 | service_role のみ | service_role のみ | service_role のみ |
| `exercises` | authenticated 全員 | 自分のもの | 自分のもの | 自分のもの |
| `exercise_body_parts` | authenticated 全員 | 自分の exercise のみ | — | 自分の exercise のみ |
| `menus` | 自分 OR `is_public=true` | 自分のみ | 自分のみ | 自分のみ |
| `menu_exercises` | 自分 OR 公開メニュー | 自分のみ | 自分のみ | 自分のみ |
| `menu_exercise_sets` | 自分 OR 公開メニュー | 自分のみ | 自分のみ | 自分のみ |
| `workout_sessions` | 自分のみ | 自分のみ | 自分のみ | 自分のみ |
| `workout_exercises` | 自分のみ | 自分のみ | 自分のみ | 自分のみ |
| `workout_sets` | 自分のみ | 自分のみ | 自分のみ | 自分のみ |

- anon（未認証）はすべてのテーブルにアクセス不可
- グローバル種目（`exercises.user_id IS NULL`）の書き込みは service_role のみ
- `menus.is_public = true` のメニューは authenticated ユーザー全員が閲覧可能

### RLSポリシー

```sql
-- ============================================================
-- body_parts
-- ============================================================
ALTER TABLE body_parts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "authenticated can read body_parts"
ON body_parts FOR SELECT
TO authenticated
USING (true);


-- ============================================================
-- equipments
-- ============================================================
ALTER TABLE equipments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "authenticated can read equipments"
ON equipments FOR SELECT
TO authenticated
USING (true);


-- ============================================================
-- exercises
-- ============================================================
ALTER TABLE exercises ENABLE ROW LEVEL SECURITY;

-- 全種目（グローバル＋自分）を閲覧可能
CREATE POLICY "authenticated can read exercises"
ON exercises FOR SELECT
TO authenticated
USING (true);

-- 自分の種目のみ作成可（user_id を自分に固定）
CREATE POLICY "users can insert own exercises"
ON exercises FOR INSERT
TO authenticated
WITH CHECK (user_id = auth.uid());

-- 自分の種目のみ更新可
CREATE POLICY "users can update own exercises"
ON exercises FOR UPDATE
TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());

-- 自分の種目のみ削除可
CREATE POLICY "users can delete own exercises"
ON exercises FOR DELETE
TO authenticated
USING (user_id = auth.uid());


-- ============================================================
-- exercise_body_parts
-- ============================================================
ALTER TABLE exercise_body_parts ENABLE ROW LEVEL SECURITY;

-- 全レコードを閲覧可能
CREATE POLICY "authenticated can read exercise_body_parts"
ON exercise_body_parts FOR SELECT
TO authenticated
USING (true);

-- 自分の種目に紐づくもののみ作成可
CREATE POLICY "users can insert own exercise_body_parts"
ON exercise_body_parts FOR INSERT
TO authenticated
WITH CHECK (
  EXISTS (
    SELECT 1 FROM exercises
    WHERE id = exercise_id AND user_id = auth.uid()
  )
);

-- 自分の種目に紐づくもののみ削除可
CREATE POLICY "users can delete own exercise_body_parts"
ON exercise_body_parts FOR DELETE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM exercises
    WHERE id = exercise_id AND user_id = auth.uid()
  )
);


-- ============================================================
-- menus
-- ============================================================
ALTER TABLE menus ENABLE ROW LEVEL SECURITY;

-- 自分のメニュー、または公開メニューを閲覧可能
CREATE POLICY "authenticated can read own or public menus"
ON menus FOR SELECT
TO authenticated
USING (user_id = auth.uid() OR is_public = true);

CREATE POLICY "users can insert own menus"
ON menus FOR INSERT
TO authenticated
WITH CHECK (user_id = auth.uid());

CREATE POLICY "users can update own menus"
ON menus FOR UPDATE
TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());

CREATE POLICY "users can delete own menus"
ON menus FOR DELETE
TO authenticated
USING (user_id = auth.uid());


-- ============================================================
-- menu_exercises
-- ============================================================
ALTER TABLE menu_exercises ENABLE ROW LEVEL SECURITY;

-- 自分のメニュー、または公開メニューのものを閲覧可能
CREATE POLICY "authenticated can read menu_exercises"
ON menu_exercises FOR SELECT
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM menus
    WHERE id = menu_id AND (user_id = auth.uid() OR is_public = true)
  )
);

CREATE POLICY "users can insert own menu_exercises"
ON menu_exercises FOR INSERT
TO authenticated
WITH CHECK (
  EXISTS (
    SELECT 1 FROM menus
    WHERE id = menu_id AND user_id = auth.uid()
  )
);

CREATE POLICY "users can update own menu_exercises"
ON menu_exercises FOR UPDATE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM menus
    WHERE id = menu_id AND user_id = auth.uid()
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM menus
    WHERE id = menu_id AND user_id = auth.uid()
  )
);

CREATE POLICY "users can delete own menu_exercises"
ON menu_exercises FOR DELETE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM menus
    WHERE id = menu_id AND user_id = auth.uid()
  )
);


-- ============================================================
-- menu_exercise_sets
-- ============================================================
ALTER TABLE menu_exercise_sets ENABLE ROW LEVEL SECURITY;

-- 自分のメニュー、または公開メニューのものを閲覧可能（2段JOIN）
CREATE POLICY "authenticated can read menu_exercise_sets"
ON menu_exercise_sets FOR SELECT
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM menu_exercises me
    JOIN menus m ON m.id = me.menu_id
    WHERE me.id = menu_exercise_id
      AND (m.user_id = auth.uid() OR m.is_public = true)
  )
);

CREATE POLICY "users can insert own menu_exercise_sets"
ON menu_exercise_sets FOR INSERT
TO authenticated
WITH CHECK (
  EXISTS (
    SELECT 1 FROM menu_exercises me
    JOIN menus m ON m.id = me.menu_id
    WHERE me.id = menu_exercise_id AND m.user_id = auth.uid()
  )
);

CREATE POLICY "users can update own menu_exercise_sets"
ON menu_exercise_sets FOR UPDATE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM menu_exercises me
    JOIN menus m ON m.id = me.menu_id
    WHERE me.id = menu_exercise_id AND m.user_id = auth.uid()
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM menu_exercises me
    JOIN menus m ON m.id = me.menu_id
    WHERE me.id = menu_exercise_id AND m.user_id = auth.uid()
  )
);

CREATE POLICY "users can delete own menu_exercise_sets"
ON menu_exercise_sets FOR DELETE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM menu_exercises me
    JOIN menus m ON m.id = me.menu_id
    WHERE me.id = menu_exercise_id AND m.user_id = auth.uid()
  )
);


-- ============================================================
-- workout_sessions
-- ============================================================
ALTER TABLE workout_sessions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "users can read own workout_sessions"
ON workout_sessions FOR SELECT
TO authenticated
USING (user_id = auth.uid());

CREATE POLICY "users can insert own workout_sessions"
ON workout_sessions FOR INSERT
TO authenticated
WITH CHECK (user_id = auth.uid());

CREATE POLICY "users can update own workout_sessions"
ON workout_sessions FOR UPDATE
TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());

CREATE POLICY "users can delete own workout_sessions"
ON workout_sessions FOR DELETE
TO authenticated
USING (user_id = auth.uid());


-- ============================================================
-- workout_exercises
-- ============================================================
ALTER TABLE workout_exercises ENABLE ROW LEVEL SECURITY;

CREATE POLICY "users can read own workout_exercises"
ON workout_exercises FOR SELECT
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM workout_sessions
    WHERE id = workout_session_id AND user_id = auth.uid()
  )
);

CREATE POLICY "users can insert own workout_exercises"
ON workout_exercises FOR INSERT
TO authenticated
WITH CHECK (
  EXISTS (
    SELECT 1 FROM workout_sessions
    WHERE id = workout_session_id AND user_id = auth.uid()
  )
);

CREATE POLICY "users can update own workout_exercises"
ON workout_exercises FOR UPDATE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM workout_sessions
    WHERE id = workout_session_id AND user_id = auth.uid()
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM workout_sessions
    WHERE id = workout_session_id AND user_id = auth.uid()
  )
);

CREATE POLICY "users can delete own workout_exercises"
ON workout_exercises FOR DELETE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM workout_sessions
    WHERE id = workout_session_id AND user_id = auth.uid()
  )
);


-- ============================================================
-- workout_sets
-- ============================================================
ALTER TABLE workout_sets ENABLE ROW LEVEL SECURITY;

CREATE POLICY "users can read own workout_sets"
ON workout_sets FOR SELECT
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM workout_exercises we
    JOIN workout_sessions ws ON ws.id = we.workout_session_id
    WHERE we.id = workout_exercise_id AND ws.user_id = auth.uid()
  )
);

CREATE POLICY "users can insert own workout_sets"
ON workout_sets FOR INSERT
TO authenticated
WITH CHECK (
  EXISTS (
    SELECT 1 FROM workout_exercises we
    JOIN workout_sessions ws ON ws.id = we.workout_session_id
    WHERE we.id = workout_exercise_id AND ws.user_id = auth.uid()
  )
);

CREATE POLICY "users can update own workout_sets"
ON workout_sets FOR UPDATE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM workout_exercises we
    JOIN workout_sessions ws ON ws.id = we.workout_session_id
    WHERE we.id = workout_exercise_id AND ws.user_id = auth.uid()
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM workout_exercises we
    JOIN workout_sessions ws ON ws.id = we.workout_session_id
    WHERE we.id = workout_exercise_id AND ws.user_id = auth.uid()
  )
);

CREATE POLICY "users can delete own workout_sets"
ON workout_sets FOR DELETE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM workout_exercises we
    JOIN workout_sessions ws ON ws.id = we.workout_session_id
    WHERE we.id = workout_exercise_id AND ws.user_id = auth.uid()
  )
);
```