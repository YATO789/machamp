import 'package:machamp/src/domain/entity/workout_history_entry.dart';
import 'package:machamp/src/infrastructures/datasource/workout_session_datasource.dart';
import 'package:machamp/src/infrastructures/model/workout_history_dto.dart';
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

  Future<List<WorkoutHistoryEntry>> fetchWorkoutSessionsByWeek({
    required DateTime weekStart,
  }) async {
    final weekEnd = weekStart.add(const Duration(days: 7));
    final rawList = await _dataSource.fetchWorkoutSessionsByWeek(
      weekStart: weekStart,
      weekEnd: weekEnd,
    );
    return rawList.map((m) => WorkoutHistoryDto.fromMap(m).toDomain()).toList();
  }
}
