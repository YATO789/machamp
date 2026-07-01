import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/src/domain/entity/exercise.dart';
import 'package:machamp/src/infrastructures/repository/auth_repository.dart';
import 'package:machamp/src/infrastructures/repository/exercise_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_selection_view_model.freezed.dart';
part 'exercise_selection_view_model.g.dart';

@freezed
abstract class ExerciseSelectionState with _$ExerciseSelectionState {
  const factory ExerciseSelectionState({
    @Default(AsyncLoading<List<Exercise>>())
    AsyncValue<List<Exercise>> exercises,
    @Default([]) List<Exercise> addedExercises,
    @Default([]) List<String> selectedIds,
  }) = _ExerciseSelectionState;
}

extension ExerciseSelectionStateX on ExerciseSelectionState {
  List<Exercise> get combinedExercises {
    final all = exercises.when(
      data: (data) => data,
      loading: () => <Exercise>[],
      error: (_, __) => <Exercise>[],
    );
    final addedIds = addedExercises.map((e) => e.id).toSet();
    final remaining = all.where((e) => !addedIds.contains(e.id)).toList();
    return [
      ...addedExercises,
      ...remaining.where((e) => e.isCustom),
      ...remaining.where((e) => !e.isCustom),
    ];
  }

  List<Exercise> get selectedExercises {
    final ids = selectedIds.toSet();
    return combinedExercises.where((e) => ids.contains(e.id)).toList();
  }
}

@riverpod
class ExerciseSelectionViewModel extends _$ExerciseSelectionViewModel {
  @override
  ExerciseSelectionState build() {
    unawaited(Future.microtask(_fetchExercises));
    return const ExerciseSelectionState();
  }

  Future<void> _fetchExercises() async {
    state = state.copyWith(exercises: const AsyncLoading());
    try {
      final user = ref.read(authRepositoryProvider).currentUser();
      if (user == null) {
        state = state.copyWith(exercises: const AsyncData([]));
        return;
      }
      final result = await ref
          .read(exerciseRepositoryProvider)
          .fetchExercises(user.id);
      state = state.copyWith(exercises: AsyncData(result));
    } catch (e, st) {
      debugPrint('ExerciseSelectionViewModel fetch error: $e\n$st');
      state = state.copyWith(exercises: AsyncError(e, st));
    }
  }

  void toggleExercise(String id) {
    final current = state.selectedIds.toSet();
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    state = state.copyWith(selectedIds: current.toList());
  }

  void addCreatedExercise(Exercise exercise) {
    state = state.copyWith(
      addedExercises: [...state.addedExercises, exercise],
      selectedIds: [...state.selectedIds, exercise.id],
    );
    unawaited(_fetchExercises());
  }
}
