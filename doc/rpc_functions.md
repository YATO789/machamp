# RPC関数

## 概要

| 関数名 | 引数 | 戻り値 | 概要 |
|---|---|---|---|
| `create_menu` | `p_name text`, `p_exercises jsonb` | `uuid` | メニューと種目・セットを一括作成 |
| `update_menu` | `p_menu_id uuid`, `p_name text`, `p_exercises jsonb` | `void` | メニューと種目・セットを一括更新 |
| `delete_menu` | `p_menu_id uuid` | `void` | メニューを削除（所有者チェックあり） |

- すべて `SECURITY DEFINER` で実行（呼び出し元ではなく関数定義者の権限で動作）
- 所有者チェックは関数内で `auth.uid()` を用いて行う

---

## create_menu

```sql
CREATE OR REPLACE FUNCTION create_menu(
  p_name      text,
  p_exercises jsonb
)
RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_menu_id       uuid;
  v_exercise_row  jsonb;
  v_set_row       jsonb;
  v_menu_ex_id    uuid;
  v_ex_order      integer := 1;
  v_set_order     integer;
BEGIN
  -- menus に挿入
  INSERT INTO menus (user_id, name)
  VALUES (auth.uid(), p_name)
  RETURNING id INTO v_menu_id;

  -- 各 exercise を menu_exercises に挿入
  FOR v_exercise_row IN SELECT * FROM jsonb_array_elements(p_exercises)
  LOOP
    INSERT INTO menu_exercises (menu_id, exercise_id, exercise_order)
    VALUES (
      v_menu_id,
      (v_exercise_row->>'exercise_id')::uuid,
      v_ex_order
    )
    RETURNING id INTO v_menu_ex_id;

    -- 各 set を menu_exercise_sets に挿入
    v_set_order := 1;
    FOR v_set_row IN SELECT * FROM jsonb_array_elements(v_exercise_row->'sets')
    LOOP
      INSERT INTO menu_exercise_sets (menu_exercise_id, set_order, reps, weight)
      VALUES (
        v_menu_ex_id,
        v_set_order,
        (v_set_row->>'reps')::integer,
        (v_set_row->>'weight')::numeric
      );
      v_set_order := v_set_order + 1;
    END LOOP;

    v_ex_order := v_ex_order + 1;
  END LOOP;

  RETURN v_menu_id;
END;
$$;
```

### p_exercises の形式

```json
[
  {
    "exercise_id": "uuid",
    "sets": [
      { "reps": 10, "weight": 60.0 },
      { "reps": 8,  "weight": 65.0 }
    ]
  }
]
```

---

## update_menu

```sql
CREATE OR REPLACE FUNCTION update_menu(
  p_menu_id   uuid,
  p_name      text,
  p_exercises jsonb
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_exercise_row  jsonb;
  v_set_row       jsonb;
  v_menu_ex_id    uuid;
  v_ex_order      integer := 1;
  v_set_order     integer;
BEGIN
  -- 所有者チェック
  IF NOT EXISTS (
    SELECT 1 FROM menus WHERE id = p_menu_id AND user_id = auth.uid()
  ) THEN
    RAISE EXCEPTION 'Not authorized';
  END IF;

  -- メニュー名を更新
  UPDATE menus SET name = p_name WHERE id = p_menu_id;

  -- 既存の menu_exercises を削除（CASCADE で menu_exercise_sets も削除）
  DELETE FROM menu_exercises WHERE menu_id = p_menu_id;

  -- 各 exercise を再挿入
  FOR v_exercise_row IN SELECT * FROM jsonb_array_elements(p_exercises)
  LOOP
    INSERT INTO menu_exercises (menu_id, exercise_id, exercise_order)
    VALUES (
      p_menu_id,
      (v_exercise_row->>'exercise_id')::uuid,
      v_ex_order
    )
    RETURNING id INTO v_menu_ex_id;

    v_set_order := 1;
    FOR v_set_row IN SELECT * FROM jsonb_array_elements(v_exercise_row->'sets')
    LOOP
      INSERT INTO menu_exercise_sets (menu_exercise_id, set_order, reps, weight)
      VALUES (
        v_menu_ex_id,
        v_set_order,
        (v_set_row->>'reps')::integer,
        (v_set_row->>'weight')::numeric
      );
      v_set_order := v_set_order + 1;
    END LOOP;

    v_ex_order := v_ex_order + 1;
  END LOOP;
END;
$$;
```

---

## delete_menu

```sql
CREATE OR REPLACE FUNCTION delete_menu(p_menu_id uuid)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM menus WHERE id = p_menu_id AND user_id = auth.uid()
  ) THEN
    RAISE EXCEPTION 'Not authorized';
  END IF;

  DELETE FROM menus WHERE id = p_menu_id;
END;
$$;
```
