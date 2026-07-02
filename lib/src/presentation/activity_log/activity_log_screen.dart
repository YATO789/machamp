import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/presentation/activity_log/widgets/calendar_bottom_sheet.dart';

class _MockSet {
  const _MockSet({required this.reps, required this.weight});
  final int reps;
  final double weight;
}

class _MockExercise {
  const _MockExercise({required this.name, required this.sets});
  final String name;
  final List<_MockSet> sets;
}

class _MockWorkout {
  const _MockWorkout({
    required this.menuName,
    required this.date,
    required this.volume,
    required this.sets,
    required this.minutes,
    this.exercises = const [],
  });
  final String menuName;
  final DateTime date;
  final double volume;
  final int sets;
  final int minutes;
  final List<_MockExercise> exercises;
}

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

class ActivityLogScreen extends HookConsumerWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final todayOnly = _dateOnly(today);

    final weekStart = useState(
      today.subtract(Duration(days: today.weekday - 1)),
    );
    final selectedDate = useState(todayOnly);

    final mockWorkouts = [
      _MockWorkout(
        menuName: '脚の日',
        date: todayOnly,
        volume: 4320,
        sets: 9,
        minutes: 42,
        exercises: [
          _MockExercise(
            name: 'スクワット',
            sets: [
              _MockSet(reps: 10, weight: 60),
              _MockSet(reps: 10, weight: 70),
              _MockSet(reps: 10, weight: 80),
            ],
          ),
          _MockExercise(
            name: 'レッグプレス',
            sets: [
              _MockSet(reps: 10, weight: 0),
              _MockSet(reps: 10, weight: 0),
              _MockSet(reps: 10, weight: 0),
            ],
          ),
        ],
      ),
      _MockWorkout(
        menuName: '胸の日',
        date: todayOnly.subtract(const Duration(days: 2)),
        volume: 3800,
        sets: 12,
        minutes: 55,
        exercises: [
          _MockExercise(
            name: 'ベンチプレス',
            sets: [
              _MockSet(reps: 10, weight: 0),
              _MockSet(reps: 10, weight: 0),
              _MockSet(reps: 10, weight: 0),
            ],
          ),
        ],
      ),
    ];

    final workoutDates = mockWorkouts.map((w) => _dateOnly(w.date)).toSet();
    final weekDates = List.generate(
      7,
      (i) => weekStart.value.add(Duration(days: i)),
    );
    final selectedWorkouts = mockWorkouts
        .where((w) => _dateOnly(w.date) == selectedDate.value)
        .toList();

    const weekDayLabels = ['月', '火', '水', '木', '金', '土', '日'];

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
                    '${weekStart.value.year}年${weekStart.value.month}月',
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
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: AppColors.monoWhite,
                            size: 15,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'カレンダー',
                            style: TextStyle(
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
            SizedBox(height: 8),
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
                                      weekDayLabels[i],
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
              child: selectedWorkouts.isEmpty
                  ? const Center(
                      child: Text(
                        'この日はワークアウトがありません',
                        style: TextStyle(color: AppColors.grey, fontSize: 14),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: selectedWorkouts.fold<int>(
                        0,
                        (sum, w) => sum + 1 + w.exercises.length,
                      ),
                      itemBuilder: (context, index) {
                        var offset = 0;
                        for (final workout in selectedWorkouts) {
                          if (index == offset) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _WorkoutCard(workout: workout),
                            );
                          }
                          offset++;
                          for (final exercise in workout.exercises) {
                            if (index == offset) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _ExerciseSection(exercise: exercise),
                              );
                            }
                            offset++;
                          }
                        }
                        return const SizedBox.shrink();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard({required this.workout});
  final _MockWorkout workout;

  String _fmtVolume(double v) {
    if (v >= 1000) {
      final k = v / 1000;
      return k % 1 == 0 ? '${k.toInt()},000' : '${k.toStringAsFixed(1)}k';
    }
    return v.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.purple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.menuName,
                      style: const TextStyle(
                        color: AppColors.monoWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatChip(
                    value: '${_fmtVolume(workout.volume)} kg',
                    label: 'ボリューム',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _StatChip(
                    value: '${workout.sets} set',
                    label: 'セット数',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _StatChip(
                    value: '${workout.minutes} 分',
                    label: '時間',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.monoWhite,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: AppColors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _ExerciseSection extends HookWidget {
  const _ExerciseSection({required this.exercise});
  final _MockExercise exercise;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => isExpanded.value = !isExpanded.value,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A3C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.name,
                          style: const TextStyle(
                            color: AppColors.monoWhite,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${exercise.sets.length}セット',
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded.value ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.grey,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipRect(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: isExpanded.value
                  ? Column(
                      children: [
                        Container(height: 1, color: const Color(0xFF2C2C2E)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 24,
                                child: Text(
                                  'No.',
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'レップ数',
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '重量(kg)',
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...exercise.sets.asMap().entries.map((entry) {
                          final i = entry.key;
                          final set = entry.value;
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 24,
                                  child: Text(
                                    '${i + 1}',
                                    style: const TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.black,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${set.reps}',
                                        style: const TextStyle(
                                          color: AppColors.monoWhite,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.black,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        set.weight % 1 == 0
                                            ? '${set.weight.toInt()}'
                                            : '${set.weight}',
                                        style: const TextStyle(
                                          color: AppColors.monoWhite,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 4),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
