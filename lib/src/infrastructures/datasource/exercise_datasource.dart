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

  Future<List<Map<String, dynamic>>> fetchExercises(String userId) async {
    final response = await _client
        .from('exercises')
        .select('id, name, body_part, equipment, user_id')
        .or('user_id.is.null,user_id.eq.$userId');
    return response;
  }

  Future<Map<String, dynamic>> createExercise({
    required String userId,
    required String name,
    required String bodyPart,
    required String equipment,
  }) async {
    final response = await _client
        .from('exercises')
        .insert({
          'name': name,
          'body_part': bodyPart,
          'equipment': equipment,
          'user_id': userId,
        })
        .select('id, name, body_part, equipment, user_id')
        .single();
    return response;
  }
}
