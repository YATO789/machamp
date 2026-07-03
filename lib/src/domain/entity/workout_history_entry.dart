import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_history_entry.freezed.dart';

@freezed
abstract class WorkoutHistoryEntry with _$WorkoutHistoryEntry {
  const factory WorkoutHistoryEntry({
    required String id,
    String? menuName,
    required DateTime startedAt,
    required DateTime finishedAt,
    required List<WorkoutHistoryExercise> exercises,
  }) = _WorkoutHistoryEntry;
}

@freezed
abstract class WorkoutHistoryExercise with _$WorkoutHistoryExercise {
  const factory WorkoutHistoryExercise({
    required String exerciseName,
    required List<WorkoutHistorySet> sets,
  }) = _WorkoutHistoryExercise;
}

@freezed
abstract class WorkoutHistorySet with _$WorkoutHistorySet {
  const factory WorkoutHistorySet({required int reps, required double weight}) =
      _WorkoutHistorySet;
}
