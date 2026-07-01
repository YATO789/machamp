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