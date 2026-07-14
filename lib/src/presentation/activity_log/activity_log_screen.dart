import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/domain/constants/date_constants.dart';
import 'package:machamp/src/domain/entity/workout_history_entry.dart';
import 'package:machamp/src/infrastructures/repository/workout_session_repository.dart';
import 'package:machamp/src/localization/app_assets.dart';
import 'package:machamp/src/presentation/activity_log/activity_log_view_model.dart';
import 'package:machamp/src/presentation/activity_log/widgets/calendar_bottom_sheet.dart';

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

String _fmtInterval(int seconds) {
  final m = seconds ~/ 60;
  final s = seconds % 60;
  return '$m:${s.toString().padLeft(2, '0')}';
}

String _fmtWeight(double w) => w % 1 == 0 ? '${w.toInt()}' : w.toString();

class ActivityLogScreen extends HookConsumerWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context).languageCode;
    final today = DateTime.now();
    final todayOnly = _dateOnly(today);

    final weekStart = useState(
      todayOnly.subtract(Duration(days: today.weekday - 1)),
    );
    final selectedDate = useState(todayOnly);

    final workoutsAsync = ref.watch(activityLogProvider(weekStart.value));

    final workouts = workoutsAsync.asData?.value ?? <WorkoutHistoryEntry>[];
    final workoutDates = workouts.map((w) => _dateOnly(w.startedAt)).toSet();
    final weekDates = List.generate(
      7,
      (i) => weekStart.value.add(Duration(days: i)),
    );
    final selectedWorkouts = workouts
        .where((w) => _dateOnly(w.startedAt) == selectedDate.value)
        .toList();

    final dayLabels = weekDayLabels(locale);
    final monthYearStr = DateFormat.yMMMM(locale).format(weekStart.value);

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    monthYearStr,
                    style: const TextStyle(
                      color: AppColors.monoWhite,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => CalendarBottomSheet.show(
                      context: context,
                      selectedDate: selectedDate.value,
                      workoutDates: workoutDates,
                      onDateSelected: (date) => selectedDate.value = date,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: AppColors.monoWhite,
                            size: 15,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppAssets.of(context)!.calendarButton,
                            style: const TextStyle(
                              color: AppColors.monoWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: AppColors.monoWhite,
                    ),
                    onPressed: () {
                      weekStart.value = weekStart.value.subtract(
                        const Duration(days: 7),
                      );
                    },
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(7, (i) {
                        final date = weekDates[i];
                        final dateOnly = _dateOnly(date);
                        final isSelected = dateOnly == selectedDate.value;
                        final hasWorkout = workoutDates.contains(dateOnly);

                        return GestureDetector(
                          onTap: () => selectedDate.value = dateOnly,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 36,
                                height: 54,
                                decoration: isSelected
                                    ? BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                    : null,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      dayLabels[i],
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppColors.black
                                            : AppColors.grey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppColors.black
                                            : AppColors.monoWhite,
                                        fontSize: 17,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: hasWorkout
                                      ? AppColors.purple
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_right,
                      color: AppColors.monoWhite,
                    ),
                    onPressed: () {
                      weekStart.value = weekStart.value.add(
                        const Duration(days: 7),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: workoutsAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.purple),
                ),
                error: (error, __) => Center(
                  child: Text(
                    AppAssets.of(context)!.errorMessage(error),
                    style: const TextStyle(color: AppColors.grey, fontSize: 14),
                  ),
                ),
                data: (_) => selectedWorkouts.isEmpty
                    ? Center(
                        child: Text(
                          AppAssets.of(context)!.noWorkoutsOnDay,
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        itemCount: selectedWorkouts.length,
                        itemBuilder: (context, index) {
                          final workout = selectedWorkouts[index];

                          Future<void> confirmAndDelete() async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: Text(
                                    AppAssets.of(ctx)!.deleteConfirmTitle(
                                      workout.menuName ??
                                          AppAssets.of(ctx)!.customWorkout,
                                    ),
                                  ),
                                  content: Text(
                                    AppAssets.of(ctx)!.irreversibleWarning,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(false),
                                      child: Text(AppAssets.of(ctx)!.cancel),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(true),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.red,
                                      ),
                                      child: Text(AppAssets.of(ctx)!.delete),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (confirmed != true) return;
                            try {
                              await ref
                                  .read(workoutSessionRepositoryProvider)
                                  .deleteWorkoutSession(workout.id);
                              ref.invalidate(
                                activityLogProvider(weekStart.value),
                              );
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppAssets.of(context)!.deleteFailed,
                                    ),
                                  ),
                                );
                              }
                            }
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _WorkoutCard(
                              entry: workout,
                              onDelete: () => unawaited(confirmAndDelete()),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard({required this.entry, this.onDelete});
  final WorkoutHistoryEntry entry;
  final VoidCallback? onDelete;

  double get _volume => entry.exercises.fold(
    0.0,
    (sum, ex) => sum + ex.sets.fold(0.0, (s, set) => s + set.reps * set.weight),
  );

  int get _totalSets =>
      entry.exercises.fold(0, (sum, ex) => sum + ex.sets.length);

  int get _minutes => entry.finishedAt.difference(entry.startedAt).inMinutes;

  String _fmtVolume(double v) {
    if (v >= 1000) {
      final k = v / 1000;
      return k % 1 == 0 ? '${k.toInt()},000' : '${k.toStringAsFixed(1)}k';
    }
    return v.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppAssets.of(context)!;
    final timeStr = DateFormat('HH:mm').format(entry.startedAt);
    final statsLine =
        '${_fmtVolume(_volume)} kg  ·  ${l.setsCount(_totalSets)}  ·  ${l.minutesValue(_minutes)}';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    entry.menuName ?? l.customWorkout,
                    style: const TextStyle(
                      color: AppColors.monoWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  timeStr,
                  style: const TextStyle(color: AppColors.grey, fontSize: 13),
                ),
                if (onDelete != null)
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'delete') onDelete!();
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(value: 'delete', child: Text(l.delete)),
                    ],
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              statsLine,
              style: const TextStyle(color: AppColors.grey, fontSize: 13),
            ),
          ),
          ...entry.exercises.mapIndexed(
            (i, exercise) =>
                _ExerciseSection(exercise: exercise, isFirst: i == 0),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}

class _ExerciseSection extends StatelessWidget {
  const _ExerciseSection({required this.exercise, required this.isFirst});
  final WorkoutHistoryExercise exercise;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final hasInterval = exercise.sets.any((s) => s.intervalSeconds > 0);

    return Padding(
      padding: EdgeInsets.fromLTRB(16, isFirst ? 0 : 14, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exercise.exerciseName,
            style: const TextStyle(
              color: AppColors.monoWhite,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          ...exercise.sets.asMap().entries.map((entry) {
            final i = entry.key;
            final set = entry.value;
            final weightReps = '${_fmtWeight(set.weight)} kg × ${set.reps}';
            final intervalStr = hasInterval && set.intervalSeconds > 0
                ? '   ${_fmtInterval(set.intervalSeconds)}'
                : '';

            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    weightReps,
                    style: const TextStyle(
                      color: AppColors.monoWhite,
                      fontSize: 14,
                    ),
                  ),
                  if (intervalStr.isNotEmpty)
                    Text(
                      intervalStr,
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 13,
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

extension<T> on Iterable<T> {
  Iterable<R> mapIndexed<R>(R Function(int index, T item) f) sync* {
    var i = 0;
    for (final item in this) {
      yield f(i++, item);
    }
  }
}
