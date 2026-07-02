import 'package:machamp/src/domain/entity/menu.dart';
import 'package:machamp/src/domain/entity/menu_exercise.dart';
import 'package:machamp/src/infrastructures/repository/menu_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_view_model.g.dart';

@riverpod
class MenuViewModel extends _$MenuViewModel {
  @override
  Future<List<Menu>> build() async {
    return ref.watch(menuRepositoryProvider).fetchMenus();
  }

  Future<void> createMenu({
    required String name,
    required List<MenuExercise> exercises,
  }) async {
    final menu = await ref.read(menuRepositoryProvider).createMenu(
      name: name,
      exercises: exercises,
    );
    state = AsyncData<List<Menu>>([...state.value ?? [], menu]);
  }

  Future<void> updateMenu({
    required String id,
    required String name,
    required List<MenuExercise> exercises,
  }) async {
    final menu = await ref.read(menuRepositoryProvider).updateMenu(
      id: id,
      name: name,
      exercises: exercises,
    );
    state = AsyncData<List<Menu>>([
      for (final m in state.value ?? <Menu>[])
        if (m.id == id) menu else m,
    ]);
  }

  Future<void> deleteMenu(String id) async {
    await ref.read(menuRepositoryProvider).deleteMenu(id);
    state = AsyncData<List<Menu>>(
      (state.value ?? []).where((m) => m.id != id).toList(),
    );
  }
}
