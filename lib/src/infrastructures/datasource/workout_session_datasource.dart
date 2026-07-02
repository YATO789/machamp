import 'package:machamp/src/infrastructures/provider/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'workout_session_datasource.g.dart';

@riverpod
WorkoutSessionDataSource workoutSessionDataSource(Ref ref) {
  return WorkoutSessionDataSource(ref.watch(supabaseClientProvider));
}

class WorkoutSessionDataSource {
  WorkoutSessionDataSource(this._client);
  final SupabaseClient _client;

  Future<void> saveWorkoutSession({
    required String menuId,
    required DateTime startedAt,
    required DateTime finishedAt,
    required List<Map<String, dynamic>> exercisesJson,
  }) async {
    await _client.rpc<void>(
      'save_workout_session',
      params: {
        'p_menu_id': menuId,
        'p_started_at': startedAt.toUtc().toIso8601String(),
        'p_finished_at': finishedAt.toUtc().toIso8601String(),
        'p_exercises': exercisesJson,
      },
    );
  }
}
