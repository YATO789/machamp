import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/domain/entity/menu.dart';
import 'package:machamp/src/domain/entity/menu_exercise.dart';
import 'package:machamp/src/infrastructures/repository/menu_repository.dart';

class MenusNotifier extends AsyncNotifier<List<Menu>> {
  @override
  Future<List<Menu>> build() async {
    final repo = ref.watch(menuRepositoryProvider);
    return repo.fetchMenus();
  }

  Future<void> createMenu({
    required String name,
    required List<MenuExercise> exercises,
  }) async {
    final menu = await ref
        .read(menuRepositoryProvider)
        .createMenu(name: name, exercises: exercises);
    state = AsyncData<List<Menu>>([...state.value ?? [], menu]);
  }

  Future<void> updateMenu({
    required String id,
    required String name,
    required List<MenuExercise> exercises,
  }) async {
    final menu = await ref
        .read(menuRepositoryProvider)
        .updateMenu(id: id, name: name, exercises: exercises);
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

final menusProvider = AsyncNotifierProvider<MenusNotifier, List<Menu>>(
  MenusNotifier.new,
);
