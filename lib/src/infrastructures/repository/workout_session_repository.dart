import 'package:machamp/src/infrastructures/datasource/workout_session_datasource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workout_session_repository.g.dart';

@riverpod
WorkoutSessionRepository workoutSessionRepository(Ref ref) {
  return WorkoutSessionRepository(ref.watch(workoutSessionDataSourceProvider));
}

class WorkoutSessionRepository {
  WorkoutSessionRepository(this._dataSource);
  final WorkoutSessionDataSource _dataSource;

  Future<void> saveWorkoutSession({
    required String menuId,
    required DateTime startedAt,
    required DateTime finishedAt,
    required List<Map<String, dynamic>> exercisesJson,
  }) async {
    await _dataSource.saveWorkoutSession(
      menuId: menuId,
      startedAt: startedAt,
      finishedAt: finishedAt,
      exercisesJson: exercisesJson,
    );
  }
}
