import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/src/domain/entity/exercise.dart';
import 'package:machamp/src/domain/entity/exercise_set.dart';
import 'package:machamp/src/domain/entity/menu_exercise.dart';
import 'package:machamp/src/presentation/menu/menu_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_editor_view_model.freezed.dart';
part 'menu_editor_view_model.g.dart';

@freezed
abstract class MenuEditorState with _$MenuEditorState {
  const factory MenuEditorState({
    @Default('') String originalName,
    @Default([]) List<MenuExercise> menuExercises,
    int? expandedIndex,
    @Default(false) bool isExercisesDirty,
    @Default(false) bool isSaving,
  }) = _MenuEditorState;
}

@riverpod
class MenuEditorViewModel extends _$MenuEditorViewModel {
  @override
  MenuEditorState build(String? menuId) {
    //TODO usecaseを作成
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
    final current = state.expandedIndex;
    final newExpanded = current == index
        ? null
        : (current != null && current > index ? current - 1 : current);
    state = state.copyWith(
      menuExercises: newList,
      expandedIndex: newExpanded,
      isExercisesDirty: true,
    );
  }

  void updateSetCount(int exerciseIndex, int newCount) {
    if (newCount < 1 || newCount > 20) return;
    final newList = List<MenuExercise>.from(state.menuExercises);
    final me = newList[exerciseIndex];
    final currentSets = me.sets;
    final List<ExerciseSet> newSets;
    if (newCount > currentSets.length) {
      newSets = [
        ...currentSets,
        ...List.generate(
          newCount - currentSets.length,
          (_) => const ExerciseSet(),
        ),
      ];
    } else {
      newSets = currentSets.sublist(0, newCount);
    }
    newList[exerciseIndex] = me.copyWith(sets: newSets);
    state = state.copyWith(menuExercises: newList, isExercisesDirty: true);
  }

  void updateSet(int exerciseIndex, int setIndex, ExerciseSet updated) {
    final newList = List<MenuExercise>.from(state.menuExercises);
    final me = newList[exerciseIndex];
    final newSets = List<ExerciseSet>.from(me.sets)..[setIndex] = updated;
    newList[exerciseIndex] = me.copyWith(sets: newSets);
    state = state.copyWith(menuExercises: newList, isExercisesDirty: true);
  }

  void addExercises(List<Exercise> exercises) {
    final newItems = exercises
        .map(
          (e) => MenuExercise(
            exercise: e,
            sets: List.generate(3, (_) => const ExerciseSet()),
          ),
        )
        .toList();
    state = state.copyWith(
      menuExercises: [...state.menuExercises, ...newItems],
      isExercisesDirty: true,
    );
  }

  void setExpandedIndex(int? index) {
    state = state.copyWith(expandedIndex: index);
  }

  Future<void> save(String name) async {
    state = state.copyWith(isSaving: true);
    try {
      if (menuId != null) {
        await ref
            .read(menuViewModelProvider.notifier)
            .updateMenu(
              id: menuId!,
              name: name,
              exercises: state.menuExercises,
            );
        state = state.copyWith(
          originalName: name,
          isExercisesDirty: false,
          isSaving: false,
        );
      } else {
        await ref
            .read(menuViewModelProvider.notifier)
            .createMenu(name: name, exercises: state.menuExercises);
        state = state.copyWith(isSaving: false);
      }
    } catch (_) {
      state = state.copyWith(isSaving: false);
      rethrow;
    }
  }
}
