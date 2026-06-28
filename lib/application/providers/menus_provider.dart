import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/domain/entity/menu.dart';

class MenusNotifier extends Notifier<List<Menu>> {
  @override
  List<Menu> build() => [];

  void addMenu(Menu menu) => state = [...state, menu];

  void updateMenu(Menu menu) => state = [
    for (final m in state)
      if (m.id == menu.id) menu else m,
  ];

  void deleteMenu(String id) => state = state.where((m) => m.id != id).toList();
}

final menusProvider = NotifierProvider<MenusNotifier, List<Menu>>(
  MenusNotifier.new,
);
