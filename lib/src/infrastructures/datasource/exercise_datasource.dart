import 'package:machamp/src/infrastructures/provider/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'exercise_datasource.g.dart';

@riverpod
ExerciseDataSource exerciseDataSource(Ref ref) {
  return ExerciseDataSource(ref.watch(supabaseClientProvider));
}

class ExerciseDataSource {
  ExerciseDataSource(this._client);
  final SupabaseClient _client;

  static const _exerciseSelect =
      'id, name, user_id, equipments(name), exercise_body_parts(body_parts(name))';

  Future<List<Map<String, dynamic>>> fetchExercises(String userId) async {
    return _client
        .from('exercises')
        .select(_exerciseSelect)
        .or('user_id.is.null,user_id.eq.$userId');
  }

  Future<List<Map<String, dynamic>>> fetchBodyParts() async {
    return _client
        .from('body_parts')
        .select('id, name, sort_order')
        .order('sort_order');
  }

  Future<List<Map<String, dynamic>>> fetchEquipments() async {
    return _client
        .from('equipments')
        .select('id, name, sort_order')
        .order('sort_order');
  }

  Future<Map<String, dynamic>> createExercise({
    required String userId,
    required String name,
    required String equipmentId,
    required List<String> bodyPartIds,
  }) async {
    final inserted = await _client
        .from('exercises')
        .insert({'name': name, 'equipment_id': equipmentId, 'user_id': userId})
        .select('id')
        .single();

    final exerciseId = inserted['id'] as String;

    await _client
        .from('exercise_body_parts')
        .insert(
          bodyPartIds
              .map((bpId) => {'exercise_id': exerciseId, 'body_part_id': bpId})
              .toList(),
        );

    return _client
        .from('exercises')
        .select(_exerciseSelect)
        .eq('id', exerciseId)
        .single();
  }
}
