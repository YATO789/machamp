import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/src/application/providers/menus_provider.dart';
import 'package:machamp/src/domain/entity/exercise.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_view_model.freezed.dart';
part 'workout_view_model.g.dart';

@freezed
abstract class WorkoutSetState with _$WorkoutSetState {
  const factory WorkoutSetState({
    required double weight,
    required int reps,
    @Default(false) bool isCompleted,
  }) = _WorkoutSetState;
}

@freezed
abstract class WorkoutExerciseState with _$WorkoutExerciseState {
  const factory WorkoutExerciseState({
    required Exercise exercise,
    required List<WorkoutSetState> sets,
    @Default(false) bool isCompleted,
  }) = _WorkoutExerciseState;
}

@freezed
abstract class WorkoutState with _$WorkoutState {
  const factory WorkoutState({
    @Default('') String menuName,
    @Default([]) List<WorkoutExerciseState> exercises,
  }) = _WorkoutState;
}

@riverpod
class WorkoutViewModel extends _$WorkoutViewModel {
  @override
  WorkoutState build(String menuId) {
    final menus = ref.read(menusProvider).value;
    final menu = menus?.where((m) => m.id == menuId).firstOrNull;
    if (menu == null) return const WorkoutState();
    return WorkoutState(
      menuName: menu.name,
      exercises: menu.exercises
          .map(
            (me) => WorkoutExerciseState(
              exercise: me.exercise,
              sets: me.sets
                  .map((s) => WorkoutSetState(weight: s.weight, reps: s.reps))
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  //TODO ビジネスロジックを移動
  void toggleSetCompleted(int exerciseIndex, int setIndex) {
    final exercises = [...state.exercises];
    final exercise = exercises[exerciseIndex];
    final sets = List<WorkoutSetState>.from(exercise.sets);
    sets[setIndex] = sets[setIndex].copyWith(
      isCompleted: !sets[setIndex].isCompleted,
    );
    exercises[exerciseIndex] = exercise.copyWith(sets: sets);
    state = state.copyWith(exercises: exercises);
  }

  void updateSetWeight(int exerciseIndex, int setIndex, double weight) {
    final exercises = [...state.exercises];
    final exercise = exercises[exerciseIndex];
    final sets = List<WorkoutSetState>.from(exercise.sets);
    sets[setIndex] = sets[setIndex].copyWith(weight: weight);
    exercises[exerciseIndex] = exercise.copyWith(sets: sets);
    state = state.copyWith(exercises: exercises);
  }

  void updateSetReps(int exerciseIndex, int setIndex, int reps) {
    final exercises = [...state.exercises];
    final exercise = exercises[exerciseIndex];
    final sets = List<WorkoutSetState>.from(exercise.sets);
    sets[setIndex] = sets[setIndex].copyWith(reps: reps);
    exercises[exerciseIndex] = exercise.copyWith(sets: sets);
    state = state.copyWith(exercises: exercises);
  }

  void toggleExerciseCompleted(int exerciseIndex) {
    final exercises = [...state.exercises];
    exercises[exerciseIndex] = exercises[exerciseIndex].copyWith(
      isCompleted: !exercises[exerciseIndex].isCompleted,
    );
    state = state.copyWith(exercises: exercises);
  }
}
