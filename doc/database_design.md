# データベース設計

## エンティティ


## テーブル

body_parts
```sql
CREATE TABLE body_parts (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text NOT NULL UNIQUE,  -- English: 'chest', 'legs', 'back', 'shoulders', 'arms', 'abs'
  sort_order  integer NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now()
);
```

equipments
```sql
CREATE TABLE equipments (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text NOT NULL UNIQUE,  -- English: 'barbell', 'dumbbell', 'machine', 'bodyweight', 'cable'
  sort_order  integer NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now()
);
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

CREATE UNIQUE INDEX exercises_official_name_unique
ON exercises(name)
WHERE user_id IS NULL;
```

exercise_body_parts
```sql
CREATE TABLE exercise_body_parts (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  exercise_id  uuid NOT NULL REFERENCES exercises(id) ON DELETE CASCADE,
  body_part_id uuid NOT NULL REFERENCES body_parts(id) ON DELETE RESTRICT,
  created_at   timestamptz NOT NULL DEFAULT now(),
  UNIQUE (exercise_id, body_part_id)
);
```

menus
```sql
CREATE TABLE menus (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name        text NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now(),
  updated_at  timestamptz NOT NULL DEFAULT now()
);
```

menu_exercises
```sql
CREATE TABLE menu_exercises (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  menu_id         uuid NOT NULL REFERENCES menus(id) ON DELETE CASCADE,
  exercise_id     uuid NOT NULL REFERENCES exercises(id) ON DELETE RESTRICT,
  exercise_order  integer NOT NULL,
  created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX menu_exercises_order_unique
ON menu_exercises(menu_id, exercise_order);
```

exercise_sets
```sql
CREATE TABLE exercise_sets (
  id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  menu_exercise_id  uuid NOT NULL REFERENCES menu_exercises(id) ON DELETE CASCADE,
  set_order         integer NOT NULL,
  reps              integer NOT NULL DEFAULT 10,
  weight            numeric(6,2) NOT NULL DEFAULT 0,
  created_at        timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX exercise_sets_order_unique
ON exercise_sets(menu_exercise_id, set_order);
```

---

workout_sessions
```sql
CREATE TABLE workout_sessions (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  menu_id     uuid REFERENCES menus(id) ON DELETE SET NULL,
  status      text NOT NULL DEFAULT 'in_progress',
  started_at  timestamptz NOT NULL DEFAULT now(),
  finished_at timestamptz,
  created_at  timestamptz NOT NULL DEFAULT now()
);
```

workout_exercises
```sql
CREATE TABLE workout_exercises (
  id                  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  workout_session_id  uuid NOT NULL REFERENCES workout_sessions(id) ON DELETE CASCADE,
  exercise_id         uuid NOT NULL REFERENCES exercises(id) ON DELETE RESTRICT,
  exercise_order      integer NOT NULL,
  created_at          timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX workout_exercises_order_unique
ON workout_exercises(workout_session_id, exercise_order);
```

workout_set
```sql
CREATE TABLE workout_sets (
  id                   uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  workout_exercise_id  uuid NOT NULL REFERENCES workout_exercises(id) ON DELETE CASCADE,
  set_order            integer NOT NULL,
  reps                 integer NOT NULL,
  weight               numeric(6,2) NOT NULL,
  created_at           timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX workout_sets_order_unique
ON workout_sets(workout_exercise_id, set_order);
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