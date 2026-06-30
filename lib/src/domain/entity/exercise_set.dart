import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_set.freezed.dart';

@freezed
abstract class ExerciseSet with _$ExerciseSet {
  const factory ExerciseSet({
    @Default(10) int reps,
    @Default(0.0) double weight,
  }) = _ExerciseSet;
}
