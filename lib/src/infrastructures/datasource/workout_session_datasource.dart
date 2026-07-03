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

  Future<List<Map<String, dynamic>>> fetchWorkoutSessionsByWeek({
    required DateTime weekStart,
    required DateTime weekEnd,
  }) async {
    final response = await _client
        .from('workout_sessions')
        .select(
          '*, menu:menus(id, name), workout_exercises(*, exercise:exercises(id, name), workout_sets(*))',
        )
        .gte('finished_at', weekStart.toUtc().toIso8601String())
        .lt('finished_at', weekEnd.toUtc().toIso8601String())
        .not('finished_at', 'is', null)
        .order('started_at', ascending: false);
    return List<Map<String, dynamic>>.from(response as List);
  }
}
