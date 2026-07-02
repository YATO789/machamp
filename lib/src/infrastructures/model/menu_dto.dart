import 'package:machamp/src/domain/entity/exercise.dart';
import 'package:machamp/src/domain/entity/exercise_set.dart';
import 'package:machamp/src/domain/entity/menu.dart';
import 'package:machamp/src/domain/entity/menu_exercise.dart';

class MenuDto {
  MenuDto.fromMap(Map<String, dynamic> map)
    : id = map['id'] as String,
      name = map['name'] as String,
      _menuExercises =
          (map['menu_exercises'] as List<dynamic>)
              .map((e) => _MenuExerciseDto.fromMap(e as Map<String, dynamic>))
              .toList()
            ..sort((a, b) => a.exerciseOrder.compareTo(b.exerciseOrder));

  final String id;
  final String name;
  final List<_MenuExerciseDto> _menuExercises;

  Menu toDomain() => Menu(
    id: id,
    name: name,
    exercises: _menuExercises.map((e) => e.toDomain()).toList(),
  );
}

class _MenuExerciseDto {
  _MenuExerciseDto.fromMap(Map<String, dynamic> map)
    : exerciseOrder = map['exercise_order'] as int,
      exercise = _ExerciseDto.fromMap(map['exercises'] as Map<String, dynamic>),
      sets =
          (map['exercise_sets'] as List<dynamic>)
              .map((s) => _ExerciseSetDto.fromMap(s as Map<String, dynamic>))
              .toList()
            ..sort((a, b) => a.setOrder.compareTo(b.setOrder));

  final int exerciseOrder;
  final _ExerciseDto exercise;
  final List<_ExerciseSetDto> sets;

  MenuExercise toDomain() => MenuExercise(
    exercise: exercise.toDomain(),
    sets: sets.map((s) => s.toDomain()).toList(),
  );
}

class _ExerciseDto {
  _ExerciseDto.fromMap(Map<String, dynamic> map)
    : id = map['id'] as String,
      name = map['name'] as String,
      bodyPart = map['body_part'] as String,
      equipment = map['equipment'] as String,
      userId = map['user_id'] as String?;

  final String id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String? userId;

  Exercise toDomain() => Exercise(
    id: id,
    name: name,
    bodyPart: bodyPart,
    equipment: equipment,
    isCustom: userId != null,
  );
}

class _ExerciseSetDto {
  _ExerciseSetDto.fromMap(Map<String, dynamic> map)
    : setOrder = map['set_order'] as int,
      reps = map['reps'] as int,
      weight = (map['weight'] as num).toDouble();

  final int setOrder;
  final int reps;
  final double weight;

  ExerciseSet toDomain() => ExerciseSet(reps: reps, weight: weight);
}
