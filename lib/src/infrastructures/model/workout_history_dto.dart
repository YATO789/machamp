import 'package:machamp/src/domain/entity/workout_history_entry.dart';

class WorkoutHistoryDto {
  WorkoutHistoryDto.fromMap(Map<String, dynamic> map)
    : id = map['id'] as String,
      menuName = map['menu'] != null
          ? (map['menu'] as Map<String, dynamic>)['name'] as String
          : null,
      startedAt = DateTime.parse(map['started_at'] as String).toLocal(),
      finishedAt = DateTime.parse(map['finished_at'] as String).toLocal(),
      _exercises =
          ((map['workout_exercises'] as List<dynamic>?) ?? [])
              .map(
                (e) => _WorkoutExerciseDto.fromMap(e as Map<String, dynamic>),
              )
              .toList()
            ..sort((a, b) => a.exerciseOrder.compareTo(b.exerciseOrder));

  final String id;
  final String? menuName;
  final DateTime startedAt;
  final DateTime finishedAt;
  final List<_WorkoutExerciseDto> _exercises;

  WorkoutHistoryEntry toDomain() => WorkoutHistoryEntry(
    id: id,
    menuName: menuName,
    startedAt: startedAt,
    finishedAt: finishedAt,
    exercises: _exercises.map((e) => e.toDomain()).toList(),
  );
}

class _WorkoutExerciseDto {
  _WorkoutExerciseDto.fromMap(Map<String, dynamic> map)
    : exerciseOrder = map['exercise_order'] as int,
      exerciseName =
          (map['exercise'] as Map<String, dynamic>)['name'] as String,
      sets =
          ((map['workout_sets'] as List<dynamic>?) ?? [])
              .map((s) => _WorkoutSetDto.fromMap(s as Map<String, dynamic>))
              .toList()
            ..sort((a, b) => a.setOrder.compareTo(b.setOrder));

  final int exerciseOrder;
  final String exerciseName;
  final List<_WorkoutSetDto> sets;

  WorkoutHistoryExercise toDomain() => WorkoutHistoryExercise(
    exerciseName: exerciseName,
    sets: sets.map((s) => s.toDomain()).toList(),
  );
}

class _WorkoutSetDto {
  _WorkoutSetDto.fromMap(Map<String, dynamic> map)
    : setOrder = map['set_order'] as int,
      reps = map['reps'] as int,
      weight = (map['weight'] as num).toDouble();

  final int setOrder;
  final int reps;
  final double weight;

  WorkoutHistorySet toDomain() => WorkoutHistorySet(reps: reps, weight: weight);
}
