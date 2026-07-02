import 'package:machamp/src/infrastructures/provider/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'menu_datasource.g.dart';

@riverpod
MenuDataSource menuDataSource(Ref ref) {
  return MenuDataSource(ref.watch(supabaseClientProvider));
}

class MenuDataSource {
  MenuDataSource(this._client);
  final SupabaseClient _client;

  static const _menuSelect = '''
    id, name,
    menu_exercises (
      exercise_order,
      exercises (id, name, body_part, equipment, user_id),
      exercise_sets (set_order, reps, weight)
    )
  ''';

  Future<List<Map<String, dynamic>>> fetchMenus() {
    return _client.from('menus').select(_menuSelect).order('created_at');
  }

  Future<Map<String, dynamic>> createMenu({
    required String name,
    required List<Map<String, dynamic>> exercisesJson,
  }) async {
    final menuId = await _client.rpc<String>('create_menu', params: {
      'p_name': name,
      'p_exercises': exercisesJson,
    });
    return _client.from('menus').select(_menuSelect).eq('id', menuId).single();
  }

  Future<Map<String, dynamic>> updateMenu({
    required String id,
    required String name,
    required List<Map<String, dynamic>> exercisesJson,
  }) async {
    await _client.rpc<void>('update_menu', params: {
      'p_menu_id': id,
      'p_name': name,
      'p_exercises': exercisesJson,
    });
    return _client.from('menus').select(_menuSelect).eq('id', id).single();
  }

  Future<void> deleteMenu(String id) async {
    await _client.rpc<void>('delete_menu', params: {'p_menu_id': id});
  }
}
