import 'package:machamp/src/domain/entity/menu.dart';
import 'package:machamp/src/infrastructures/repository/menu_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_view_model.g.dart';

@riverpod
class MenuViewModel extends _$MenuViewModel {
  @override
  Future<List<Menu>> build() async {
    return ref.watch(menuRepositoryProvider).fetchMenus();
  }
}
