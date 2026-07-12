-- ============================================================
-- body_parts
-- ============================================================
INSERT INTO body_parts (name, sort_order) VALUES
  ('legs',      1),
  ('chest',     2),
  ('back',      3),
  ('shoulders', 4),
  ('arms',      5),
  ('abs',       6)
ON CONFLICT (name) DO NOTHING;


-- ============================================================
-- equipments
-- ============================================================
INSERT INTO equipments (name, sort_order) VALUES
  ('barbell',    1),
  ('dumbbell',   2),
  ('machine',    3),
  ('bodyweight', 4),
  ('cable',      5)
ON CONFLICT (name) DO NOTHING;


-- ============================================================
-- exercises (global, user_id IS NULL)
-- ============================================================
INSERT INTO exercises (name, equipment_id, user_id) VALUES
  -- Chest / Barbell
  ('Bench Press',                        (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Incline Bench Press',                (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Decline Bench Press',                (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Close-Grip Bench Press',             (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Landmine Press',                     (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  -- Chest / Dumbbell
  ('Dumbbell Bench Press',               (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Incline Dumbbell Bench Press',       (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Decline Dumbbell Bench Press',       (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Dumbbell Fly',                       (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Incline Dumbbell Fly',               (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Decline Dumbbell Fly',               (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  -- Chest / Machine
  ('Machine Chest Press',                (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Smith Machine Bench Press',          (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Pec Deck Fly',                       (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Butterfly Machine',                  (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  -- Chest / Bodyweight
  ('Push-up',                            (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Wide Push-up',                       (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Incline Push-up',                    (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Decline Push-up',                    (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Dips',                               (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  -- Chest / Cable
  ('Cable Crossover',                    (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Cable Fly',                          (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Low Pulley Fly',                     (SELECT id FROM equipments WHERE name = 'cable'),      NULL),

  -- Back / Barbell
  ('Deadlift',                           (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Barbell Row',                        (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Pendlay Row',                        (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('T-Bar Row',                          (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Romanian Deadlift',                  (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Sumo Deadlift',                      (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  -- Back / Dumbbell
  ('Dumbbell Row',                       (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Incline Dumbbell Row',               (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Dumbbell Pullover',                  (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  -- Back / Machine
  ('Lat Pulldown',                       (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Wide-Grip Lat Pulldown',             (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Close-Grip Lat Pulldown',            (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Reverse-Grip Lat Pulldown',          (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Seated Row Machine',                 (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Assisted Pull-up',                   (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  -- Back / Bodyweight
  ('Pull-up',                            (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Chin-up',                            (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Inverted Row',                       (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  -- Back / Cable
  ('Seated Cable Row',                   (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Single Arm Cable Row',               (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Cable Pullover',                     (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Straight Arm Pulldown',              (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Cable Face Pull',                    (SELECT id FROM equipments WHERE name = 'cable'),      NULL),

  -- Legs / Barbell
  ('Barbell Back Squat',                 (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Front Squat',                        (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Barbell Lunge',                      (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Hip Thrust',                         (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  -- Legs / Dumbbell
  ('Goblet Squat',                       (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Dumbbell Squat',                     (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Dumbbell Lunge',                     (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Bulgarian Split Squat',              (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Dumbbell Hip Thrust',                (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Step Up',                            (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  -- Legs / Machine
  ('Leg Press',                          (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Leg Curl',                           (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Leg Extension',                      (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Leg Adduction',                      (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Leg Abduction',                      (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Standing Calf Raise',                (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Seated Calf Raise',                  (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Hack Squat',                         (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  -- Legs / Bodyweight
  ('Squat',                              (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Lunge',                              (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Glute Bridge',                       (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Calf Raise',                         (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  -- Legs / Cable
  ('Cable Kickback',                     (SELECT id FROM equipments WHERE name = 'cable'),      NULL),

  -- Shoulders / Barbell
  ('Barbell Shoulder Press',             (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Upright Row',                        (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Barbell Shrug',                      (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Behind-the-Neck Press',              (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Plate Front Raise',                  (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  -- Shoulders / Dumbbell
  ('Dumbbell Shoulder Press',            (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Arnold Press',                       (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Lateral Raise',                      (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Front Raise',                        (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Rear Delt Fly',                      (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Dumbbell Upright Row',               (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Dumbbell Shrug',                     (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Seated Lateral Raise',               (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  -- Shoulders / Machine
  ('Machine Shoulder Press',             (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Machine Lateral Raise',              (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Rear Delt Machine',                  (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  -- Shoulders / Bodyweight
  ('Pike Push-up',                       (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Handstand Push-up',                  (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  -- Shoulders / Cable
  ('Cable Lateral Raise',                (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Cable Front Raise',                  (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Face Pull',                          (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Cable Rear Delt Fly',                (SELECT id FROM equipments WHERE name = 'cable'),      NULL),

  -- Arms / Barbell
  ('Barbell Curl',                       (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('EZ Bar Curl',                        (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Barbell Preacher Curl',              (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Reverse Curl',                       (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Skull Crusher',                      (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Wrist Curl',                         (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  ('Reverse Wrist Curl',                 (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  -- Arms / Dumbbell
  ('Dumbbell Curl',                      (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Hammer Curl',                        (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Incline Dumbbell Curl',              (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Concentration Curl',                 (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Dumbbell Triceps Extension',         (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Dumbbell Kickback',                  (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  ('Dumbbell Wrist Curl',                (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  -- Arms / Machine
  ('Machine Preacher Curl',              (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Machine Curl',                       (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Machine Triceps Extension',          (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  -- Arms / Bodyweight
  ('Bench Dips',                         (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Diamond Push-up',                    (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  -- Arms / Cable
  ('Cable Curl',                         (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('High Pulley Curl',                   (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Triceps Pushdown',                   (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Cable Overhead Triceps Extension',   (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Rope Triceps Pushdown',              (SELECT id FROM equipments WHERE name = 'cable'),      NULL),

  -- Abs / Barbell
  ('Landmine Twist',                     (SELECT id FROM equipments WHERE name = 'barbell'),    NULL),
  -- Abs / Dumbbell
  ('Dumbbell Side Bend',                 (SELECT id FROM equipments WHERE name = 'dumbbell'),   NULL),
  -- Abs / Bodyweight
  ('Crunch',                             (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Reverse Crunch',                     (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Bicycle Crunch',                     (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Leg Raise',                          (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Hanging Leg Raise',                  (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Hanging Knee Raise',                 (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Knee Raise',                         (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Plank',                              (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Side Plank',                         (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Russian Twist',                      (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('V-Up',                               (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Toe Touch',                          (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Sit-up',                             (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Ab Wheel Rollout',                   (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Dragon Flag',                        (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  ('Mountain Climber',                   (SELECT id FROM equipments WHERE name = 'bodyweight'), NULL),
  -- Abs / Machine
  ('Ab Machine',                         (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  ('Decline Crunch',                     (SELECT id FROM equipments WHERE name = 'machine'),    NULL),
  -- Abs / Cable
  ('Cable Crunch',                       (SELECT id FROM equipments WHERE name = 'cable'),      NULL),
  ('Wood Chop',                          (SELECT id FROM equipments WHERE name = 'cable'),      NULL)
ON CONFLICT (name) WHERE user_id IS NULL DO NOTHING;


-- ============================================================
-- exercise_body_parts
-- ============================================================
INSERT INTO exercise_body_parts (exercise_id, body_part_id)
SELECT e.id, bp.id
FROM (VALUES
  -- Chest (single)
  ('Bench Press',                      'chest'),
  ('Incline Bench Press',              'chest'),
  ('Decline Bench Press',              'chest'),
  ('Landmine Press',                   'chest'),
  ('Dumbbell Bench Press',             'chest'),
  ('Incline Dumbbell Bench Press',     'chest'),
  ('Decline Dumbbell Bench Press',     'chest'),
  ('Dumbbell Fly',                     'chest'),
  ('Incline Dumbbell Fly',             'chest'),
  ('Decline Dumbbell Fly',             'chest'),
  ('Machine Chest Press',              'chest'),
  ('Smith Machine Bench Press',        'chest'),
  ('Pec Deck Fly',                     'chest'),
  ('Butterfly Machine',                'chest'),
  ('Push-up',                          'chest'),
  ('Wide Push-up',                     'chest'),
  ('Incline Push-up',                  'chest'),
  ('Decline Push-up',                  'chest'),
  ('Dips',                             'chest'),
  ('Cable Crossover',                  'chest'),
  ('Cable Fly',                        'chest'),
  ('Low Pulley Fly',                   'chest'),
  -- Close-Grip Bench Press: chest + arms
  ('Close-Grip Bench Press',           'chest'),
  ('Close-Grip Bench Press',           'arms'),

  -- Back (single)
  ('Deadlift',                         'back'),
  ('Barbell Row',                      'back'),
  ('Pendlay Row',                      'back'),
  ('T-Bar Row',                        'back'),
  ('Dumbbell Row',                     'back'),
  ('Incline Dumbbell Row',             'back'),
  ('Dumbbell Pullover',                'back'),
  ('Lat Pulldown',                     'back'),
  ('Wide-Grip Lat Pulldown',           'back'),
  ('Close-Grip Lat Pulldown',          'back'),
  ('Reverse-Grip Lat Pulldown',        'back'),
  ('Seated Row Machine',               'back'),
  ('Assisted Pull-up',                 'back'),
  ('Pull-up',                          'back'),
  ('Chin-up',                          'back'),
  ('Inverted Row',                     'back'),
  ('Seated Cable Row',                 'back'),
  ('Single Arm Cable Row',             'back'),
  ('Cable Pullover',                   'back'),
  ('Straight Arm Pulldown',            'back'),
  ('Cable Face Pull',                  'back'),
  -- Romanian Deadlift: back + legs
  ('Romanian Deadlift',                'back'),
  ('Romanian Deadlift',                'legs'),
  -- Sumo Deadlift: back + legs
  ('Sumo Deadlift',                    'back'),
  ('Sumo Deadlift',                    'legs'),

  -- Legs (single)
  ('Barbell Back Squat',               'legs'),
  ('Front Squat',                      'legs'),
  ('Barbell Lunge',                    'legs'),
  ('Hip Thrust',                       'legs'),
  ('Goblet Squat',                     'legs'),
  ('Dumbbell Squat',                   'legs'),
  ('Dumbbell Lunge',                   'legs'),
  ('Bulgarian Split Squat',            'legs'),
  ('Dumbbell Hip Thrust',              'legs'),
  ('Step Up',                          'legs'),
  ('Leg Press',                        'legs'),
  ('Leg Curl',                         'legs'),
  ('Leg Extension',                    'legs'),
  ('Leg Adduction',                    'legs'),
  ('Leg Abduction',                    'legs'),
  ('Standing Calf Raise',              'legs'),
  ('Seated Calf Raise',                'legs'),
  ('Hack Squat',                       'legs'),
  ('Squat',                            'legs'),
  ('Lunge',                            'legs'),
  ('Glute Bridge',                     'legs'),
  ('Calf Raise',                       'legs'),
  ('Cable Kickback',                   'legs'),

  -- Shoulders (single)
  ('Barbell Shoulder Press',           'shoulders'),
  ('Upright Row',                      'shoulders'),
  ('Barbell Shrug',                    'shoulders'),
  ('Behind-the-Neck Press',            'shoulders'),
  ('Plate Front Raise',                'shoulders'),
  ('Dumbbell Shoulder Press',          'shoulders'),
  ('Arnold Press',                     'shoulders'),
  ('Lateral Raise',                    'shoulders'),
  ('Front Raise',                      'shoulders'),
  ('Rear Delt Fly',                    'shoulders'),
  ('Dumbbell Upright Row',             'shoulders'),
  ('Dumbbell Shrug',                   'shoulders'),
  ('Seated Lateral Raise',             'shoulders'),
  ('Machine Shoulder Press',           'shoulders'),
  ('Machine Lateral Raise',            'shoulders'),
  ('Rear Delt Machine',                'shoulders'),
  ('Pike Push-up',                     'shoulders'),
  ('Handstand Push-up',                'shoulders'),
  ('Cable Lateral Raise',              'shoulders'),
  ('Cable Front Raise',                'shoulders'),
  ('Face Pull',                        'shoulders'),
  ('Cable Rear Delt Fly',              'shoulders'),

  -- Arms (single)
  ('Barbell Curl',                     'arms'),
  ('EZ Bar Curl',                      'arms'),
  ('Barbell Preacher Curl',            'arms'),
  ('Reverse Curl',                     'arms'),
  ('Skull Crusher',                    'arms'),
  ('Wrist Curl',                       'arms'),
  ('Reverse Wrist Curl',               'arms'),
  ('Dumbbell Curl',                    'arms'),
  ('Hammer Curl',                      'arms'),
  ('Incline Dumbbell Curl',            'arms'),
  ('Concentration Curl',               'arms'),
  ('Dumbbell Triceps Extension',       'arms'),
  ('Dumbbell Kickback',                'arms'),
  ('Dumbbell Wrist Curl',              'arms'),
  ('Machine Preacher Curl',            'arms'),
  ('Machine Curl',                     'arms'),
  ('Machine Triceps Extension',        'arms'),
  ('Bench Dips',                       'arms'),
  ('Diamond Push-up',                  'arms'),
  ('Cable Curl',                       'arms'),
  ('High Pulley Curl',                 'arms'),
  ('Triceps Pushdown',                 'arms'),
  ('Cable Overhead Triceps Extension', 'arms'),
  ('Rope Triceps Pushdown',            'arms'),

  -- Abs (single)
  ('Landmine Twist',                   'abs'),
  ('Dumbbell Side Bend',               'abs'),
  ('Crunch',                           'abs'),
  ('Reverse Crunch',                   'abs'),
  ('Bicycle Crunch',                   'abs'),
  ('Leg Raise',                        'abs'),
  ('Hanging Leg Raise',                'abs'),
  ('Hanging Knee Raise',               'abs'),
  ('Knee Raise',                       'abs'),
  ('Plank',                            'abs'),
  ('Side Plank',                       'abs'),
  ('Russian Twist',                    'abs'),
  ('V-Up',                             'abs'),
  ('Toe Touch',                        'abs'),
  ('Sit-up',                           'abs'),
  ('Ab Wheel Rollout',                 'abs'),
  ('Dragon Flag',                      'abs'),
  ('Mountain Climber',                 'abs'),
  ('Ab Machine',                       'abs'),
  ('Decline Crunch',                   'abs'),
  ('Cable Crunch',                     'abs'),
  ('Wood Chop',                        'abs')
) AS mapping(exercise_name, body_part_name)
JOIN exercises e  ON e.name  = mapping.exercise_name  AND e.user_id IS NULL
JOIN body_parts bp ON bp.name = mapping.body_part_name
ON CONFLICT (exercise_id, body_part_id) DO NOTHING;
