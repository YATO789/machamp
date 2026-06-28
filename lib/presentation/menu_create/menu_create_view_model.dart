import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/application/providers/menus_provider.dart';
import 'package:machamp/domain/entity/exercise.dart';
import 'package:machamp/domain/entity/exercise_set.dart';
import 'package:machamp/domain/entity/menu.dart';
import 'package:machamp/domain/entity/menu_exercise.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_create_view_model.freezed.dart';
part 'menu_create_view_model.g.dart';

@freezed
abstract class MenuCreateState with _$MenuCreateState {
  const factory MenuCreateState({
    @Default([]) List<MenuExercise> menuExercises,
    int? expandedIndex,
  }) = _MenuCreateState;
}

@riverpod
class MenuCreateViewModel extends _$MenuCreateViewModel {
  @override
  MenuCreateState build(String? menuId) {
    final menus = ref.read(menusProvider);
    final existingMenu = menuId != null
        ? menus.where((m) => m.id == menuId).firstOrNull
        : null;
    return MenuCreateState(
      menuExercises: existingMenu != null
          ? List.from(existingMenu.exercises)
          : [],
    );
  }

  //TODO: ビジネスロジックを移す
  void removeExercise(int index) {
    final newList = List<MenuExercise>.from(state.menuExercises)
      ..removeAt(index);
    final current = state.expandedIndex;
    final newExpanded = current == index
        ? null
        : (current != null && current > index ? current - 1 : current);
    state = state.copyWith(menuExercises: newList, expandedIndex: newExpanded);
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
    state = state.copyWith(menuExercises: newList);
  }

  void updateSet(int exerciseIndex, int setIndex, ExerciseSet updated) {
    final newList = List<MenuExercise>.from(state.menuExercises);
    final me = newList[exerciseIndex];
    final newSets = List<ExerciseSet>.from(me.sets)..[setIndex] = updated;
    newList[exerciseIndex] = me.copyWith(sets: newSets);
    state = state.copyWith(menuExercises: newList);
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
    );
  }

  void setExpandedIndex(int? index) {
    state = state.copyWith(expandedIndex: index);
  }

  void save(String name) {
    if (menuId != null) {
      final existingMenu = ref
          .read(menusProvider)
          .where((m) => m.id == menuId)
          .firstOrNull;
      if (existingMenu != null) {
        ref
            .read(menusProvider.notifier)
            .updateMenu(
              existingMenu.copyWith(name: name, exercises: state.menuExercises),
            );
      }
    } else {
      ref
          .read(menusProvider.notifier)
          .addMenu(
            Menu(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: name,
              exercises: state.menuExercises,
            ),
          );
    }
  }
}
