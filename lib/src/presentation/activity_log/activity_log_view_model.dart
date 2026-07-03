import 'package:machamp/src/domain/entity/workout_history_entry.dart';
import 'package:machamp/src/infrastructures/repository/workout_session_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_log_view_model.g.dart';

@riverpod
Future<List<WorkoutHistoryEntry>> activityLog(Ref ref, DateTime weekStart) {
  return ref
      .watch(workoutSessionRepositoryProvider)
      .fetchWorkoutSessionsByWeek(weekStart: weekStart);
}
