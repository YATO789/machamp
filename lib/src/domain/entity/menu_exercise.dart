import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/src/domain/entity/exercise.dart';
import 'package:machamp/src/domain/entity/exercise_set.dart';

part 'menu_exercise.freezed.dart';

@freezed
abstract class MenuExercise with _$MenuExercise {
  const factory MenuExercise({
    required Exercise exercise,
    required List<ExerciseSet> sets,
  }) = _MenuExercise;
}
