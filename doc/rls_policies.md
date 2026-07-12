# RLS（Row Level Security）ポリシー

## 方針まとめ

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

---

## GRANT

```sql
GRANT SELECT ON public.body_parts TO authenticated;
GRANT SELECT ON public.equipments TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.exercises TO authenticated;
GRANT SELECT, INSERT, DELETE ON public.exercise_body_parts TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.menus TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.menu_exercises TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.menu_exercise_sets TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.workout_sessions TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.workout_exercises TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.workout_sets TO authenticated;
```

---

## body_parts

```sql
ALTER TABLE body_parts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "authenticated can read body_parts"
ON body_parts FOR SELECT
TO authenticated
USING (true);
```

---

## equipments

```sql
ALTER TABLE equipments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "authenticated can read equipments"
ON equipments FOR SELECT
TO authenticated
USING (true);
```

---

## exercises

```sql
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
```

---

## exercise_body_parts

```sql
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
```

---

## menus

```sql
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
```

---

## menu_exercises

```sql
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
```

---

## menu_exercise_sets

```sql
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
```

---

## workout_sessions

```sql
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
```

---

## workout_exercises

```sql
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
```

---

## workout_sets

```sql
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
