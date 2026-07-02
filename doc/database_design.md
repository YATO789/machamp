# データベース設計

## エンティティ


## テーブル

exercises
```sql
CREATE TABLE exercises (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text NOT NULL,
  body_part   text NOT NULL,
  equipment   text NOT NULL,
  user_id     uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at  timestamptz NOT NULL DEFAULT now(),
  updated_at  timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX exercises_official_name_unique
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

## ER図
```
auth.users
│
├── exercises
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