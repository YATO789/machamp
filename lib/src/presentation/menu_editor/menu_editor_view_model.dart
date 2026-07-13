import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/src/domain/entity/exercise.dart';
import 'package:machamp/src/domain/entity/exercise_set.dart';
import 'package:machamp/src/domain/entity/menu_exercise.dart';
import 'package:machamp/src/infrastructures/repository/menu_repository.dart';
import 'package:machamp/src/presentation/menu/menu_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_editor_view_model.freezed.dart';
part 'menu_editor_view_model.g.dart';

@freezed
abstract class MenuEditorState with _$MenuEditorState {
  const factory MenuEditorState({
    @Default('') String originalName,
    @Default([]) List<MenuExercise> menuExercises,
    @Default(<int>{}) Set<int> expandedIndices,
    @Default(false) bool isExercisesDirty,
    @Default(false) bool isSaving,
    @Default(false) bool isDeleting,
  }) = _MenuEditorState;
}

@riverpod
class MenuEditorViewModel extends _$MenuEditorViewModel {
  @override
  MenuEditorState build(String? menuId) {
    final menu = menuId != null
        ? ref
              .read(menuViewModelProvider)
              .value
              ?.where((m) => m.id == menuId)
              .firstOrNull
        : null;
    return MenuEditorState(
      originalName: menu?.name ?? '',
      menuExercises: menu != null ? List.from(menu.exercises) : [],
    );
  }

  void removeExercise(int index) {
    final newList = List<MenuExercise>.from(state.menuExercises)
      ..removeAt(index);
    final newExpanded = state.expandedIndices
        .where((i) => i != index)
        .map((i) => i > index ? i - 1 : i)
        .toSet();
    state = state.copyWith(
      menuExercises: newList,
      expandedIndices: newExpanded,
      isExercisesDirty: true,
    );
  }

  void updateSetCount(int exerciseIndex, int newCount) {
    if (newCount < 1 || newCount > 20) return;
    final newList = List<MenuExercise>.from(state.menuExercises);
    final menu = newList[exerciseIndex];
    final currentSets = menu.sets;
    final List<ExerciseSet> newSets;
    if (newCount > currentSets.length) {
      final lastSet = currentSets.isNotEmpty
          ? currentSets.last
          : const ExerciseSet();
      newSets = [
        ...currentSets,
        ...List.generate(newCount - currentSets.length, (_) => lastSet),
      ];
    } else {
      newSets = currentSets.sublist(0, newCount);
    }
    newList[exerciseIndex] = menu.copyWith(sets: newSets);
    state = state.copyWith(menuExercises: newList, isExercisesDirty: true);
  }

  void updateSet(int exerciseIndex, int setIndex, ExerciseSet updated) {
    final newList = List<MenuExercise>.from(state.menuExercises);
    final menu = newList[exerciseIndex];
    final newSets = List<ExerciseSet>.from(menu.sets)..[setIndex] = updated;
    newList[exerciseIndex] = menu.copyWith(sets: newSets);
    state = state.copyWith(menuExercises: newList, isExercisesDirty: true);
  }

  void addExercises(List<Exercise> exercises) {
    final newItems = exercises
        .map(
          (e) => MenuExercise(
            exercise: e,
            sets: List.generate(1, (_) => const ExerciseSet()),
          ),
        )
        .toList();
    state = state.copyWith(
      menuExercises: [...state.menuExercises, ...newItems],
      isExercisesDirty: true,
    );
  }

  void reorderExercises(int oldIndex, int newIndex) {
    final list = List<MenuExercise>.from(state.menuExercises);
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);

    final newExpanded = <int>{};
    for (final i in state.expandedIndices) {
      if (i == oldIndex) {
        newExpanded.add(newIndex);
      } else if (oldIndex < newIndex) {
        newExpanded.add(i > oldIndex && i <= newIndex ? i - 1 : i);
      } else {
        newExpanded.add(i >= newIndex && i < oldIndex ? i + 1 : i);
      }
    }

    state = state.copyWith(
      menuExercises: list,
      expandedIndices: newExpanded,
      isExercisesDirty: true,
    );
  }

  void toggleExpandedIndex(int index) {
    final next = Set<int>.from(state.expandedIndices);
    if (next.contains(index)) {
      next.remove(index);
    } else {
      next.add(index);
    }
    state = state.copyWith(expandedIndices: next);
  }

  Future<void> deleteMenu() async {
    if (menuId == null) return;
    state = state.copyWith(isDeleting: true);
    try {
      await ref.read(menuRepositoryProvider).deleteMenu(menuId!);
      ref.invalidate(menuViewModelProvider);
    } catch (_) {
      state = state.copyWith(isDeleting: false);
      rethrow;
    }
  }

  Future<void> save(String name) async {
    state = state.copyWith(isSaving: true);
    try {
      if (menuId != null) {
        await ref
            .read(menuRepositoryProvider)
            .updateMenu(
              id: menuId!,
              name: name,
              exercises: state.menuExercises,
            );
        ref.invalidate(menuViewModelProvider);
        state = state.copyWith(
          originalName: name,
          isExercisesDirty: false,
          isSaving: false,
        );
      } else {
        await ref
            .read(menuRepositoryProvider)
            .createMenu(name: name, exercises: state.menuExercises);
        ref.invalidate(menuViewModelProvider);
        state = state.copyWith(isSaving: false);
      }
    } catch (_) {
      state = state.copyWith(isSaving: false);
      rethrow;
    }
  }
}
