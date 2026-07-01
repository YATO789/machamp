import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/src/domain/entity/exercise.dart';
import 'package:machamp/src/infrastructures/repository/auth_repository.dart';
import 'package:machamp/src/infrastructures/repository/exercise_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_creation_view_model.freezed.dart';
part 'exercise_creation_view_model.g.dart';

@freezed
abstract class ExerciseCreationState with _$ExerciseCreationState {
  const factory ExerciseCreationState({
    @Default(false) bool isLoading,
  }) = _ExerciseCreationState;
}

@riverpod
class ExerciseCreationViewModel extends _$ExerciseCreationViewModel {
  @override
  ExerciseCreationState build() => const ExerciseCreationState();

  Future<Exercise?> createExercise({
    required String name,
    required String bodyPart,
    required String equipment,
  }) async {
    final user = ref.read(authRepositoryProvider).currentUser();
    if (user == null) return null;
    state = state.copyWith(isLoading: true);
    try {
      return await ref.read(exerciseRepositoryProvider).createExercise(
        userId: user.id,
        name: name,
        bodyPart: bodyPart,
        equipment: equipment,
      );
    } catch (e, st) {
      debugPrint('ExerciseCreationViewModel error: $e\n$st');
      return null;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
