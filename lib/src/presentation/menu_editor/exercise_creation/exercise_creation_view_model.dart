import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/src/domain/entity/body_part.dart';
import 'package:machamp/src/domain/entity/equipment.dart';
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
    @Default(AsyncLoading<List<BodyPart>>())
    AsyncValue<List<BodyPart>> bodyParts,
    @Default(AsyncLoading<List<Equipment>>())
    AsyncValue<List<Equipment>> equipments,
  }) = _ExerciseCreationState;
}

@riverpod
class ExerciseCreationViewModel extends _$ExerciseCreationViewModel {
  @override
  ExerciseCreationState build() {
    unawaited(Future.microtask(_loadMasterData));
    return const ExerciseCreationState();
  }

  Future<void> _loadMasterData() async {
    try {
      final repo = ref.read(exerciseRepositoryProvider);
      final bodyPartsFuture = repo.fetchBodyParts();
      final equipmentsFuture = repo.fetchEquipments();
      final bodyParts = await bodyPartsFuture;
      final equipments = await equipmentsFuture;
      state = state.copyWith(
        bodyParts: AsyncData(bodyParts),
        equipments: AsyncData(equipments),
      );
    } catch (e, st) {
      debugPrint('ExerciseCreationViewModel loadMasterData error: $e\n$st');
      state = state.copyWith(
        bodyParts: AsyncError(e, st),
        equipments: AsyncError(e, st),
      );
    }
  }

  Future<Exercise?> createExercise({
    required String name,
    required String equipmentId,
    required List<String> bodyPartIds,
  }) async {
    final user = ref.read(authRepositoryProvider).currentUser();
    if (user == null) return null;
    state = state.copyWith(isLoading: true);
    try {
      return await ref
          .read(exerciseRepositoryProvider)
          .createExercise(
            userId: user.id,
            name: name,
            equipmentId: equipmentId,
            bodyPartIds: bodyPartIds,
          );
    } catch (e, st) {
      debugPrint('ExerciseCreationViewModel createExercise error: $e\n$st');
      return null;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
