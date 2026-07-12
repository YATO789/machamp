import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/localization/app_assets.dart';
import 'package:machamp/src/presentation/share_preview/share_preview_args.dart';
import 'package:machamp/src/presentation/workout/workout_view_model.dart';

class WorkoutSummaryScreen extends HookWidget {
  const WorkoutSummaryScreen({super.key, required this.workoutState});

  final WorkoutState workoutState;

  @override
  Widget build(BuildContext context) {
    final completedExercises = workoutState.exercises
        .map(
          (ex) =>
              ex.copyWith(sets: ex.sets.where((s) => s.isCompleted).toList()),
        )
        .where((ex) => ex.sets.isNotEmpty)
        .toList();

    final totalSets = completedExercises.fold(
      0,
      (sum, ex) => sum + ex.sets.length,
    );
    final totalReps = completedExercises.fold(
      0,
      (sum, ex) => ex.sets.fold(sum, (s, set) => s + set.reps),
    );
    final totalVolume = completedExercises.fold(
      0.0,
      (sum, ex) => ex.sets.fold(sum, (s, set) => s + set.weight * set.reps),
    );

    final elapsed =
        workoutState.startedAt != null && workoutState.finishedAt != null
        ? workoutState.finishedAt!.difference(workoutState.startedAt!)
        : null;
    final elapsedStr = elapsed != null
        ? '${elapsed.inMinutes.remainder(60).toString().padLeft(2, '0')}:${elapsed.inSeconds.remainder(60).toString().padLeft(2, '0')}'
        : '--:--';

    Future<void> showShareFlow() async {
      final currentUri = GoRouterState.of(context).uri.toString();

      final source = await showModalBottomSheet<ImageSource>(
        context: context,
        backgroundColor: AppColors.darkSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (ctx) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt,
                    color: AppColors.monoWhite,
                  ),
                  title: Text(
                    AppAssets.of(ctx)!.camera,
                    style: const TextStyle(color: AppColors.monoWhite),
                  ),
                  onTap: () => Navigator.pop(ctx, ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: AppColors.monoWhite,
                  ),
                  title: Text(
                    AppAssets.of(ctx)!.photoLibrary,
                    style: const TextStyle(color: AppColors.monoWhite),
                  ),
                  onTap: () => Navigator.pop(ctx, ImageSource.gallery),
                ),
              ],
            ),
          );
        },
      );
      if (source == null) return;

      final picked = await ImagePicker().pickImage(
        source: source,
        imageQuality: 90,
      );
      if (picked == null || !context.mounted) return;

      final now = DateTime.now();
      final started = workoutState.startedAt;
      final durationMinutes = started != null
          ? now.difference(started).inMinutes
          : 0;

      final volumeStr = totalVolume % 1 == 0
          ? totalVolume.toInt().toString()
          : totalVolume.toStringAsFixed(1);

      unawaited(
        context.push(
          '$currentUri/share',
          extra: SharePreviewArgs(
            backgroundImage: File(picked.path),
            workoutName: workoutState.menuName.isEmpty
                ? 'Workout'
                : workoutState.menuName,
            totalVolume: volumeStr,
            totalSets: totalSets,
            date: now,
            durationMinutes: durationMinutes,
          ),
        ),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            workoutState.menuName.isEmpty
                ? AppAssets.of(context)!.workoutCompleteFallback
                : workoutState.menuName,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildStatsGrid(
                      context,
                      totalVolume,
                      totalSets,
                      totalReps,
                      elapsedStr,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppAssets.of(context)!.exerciseLogTitle,
                      style: const TextStyle(
                        color: AppColors.monoWhite,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...completedExercises.map(
                      (ex) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _ExerciseLogCard(exercise: ex),
                      ),
                    ),
                    if (completedExercises.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Text(
                            AppAssets.of(context)!.noCompletedSets,
                            style: const TextStyle(color: AppColors.grey),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        onPressed: showShareFlow,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.purple),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          AppAssets.of(context)!.shareOnSns,
                          style: const TextStyle(
                            color: AppColors.purple,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => context.go('/home'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkSurface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          AppAssets.of(context)!.close,
                          style: const TextStyle(
                            color: AppColors.monoWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _fmtVolume(double v) {
    if (v % 1 == 0) return v.toInt().toString();
    return v.toStringAsFixed(1);
  }

  Widget _buildStatsGrid(
    BuildContext context,
    double totalVolume,
    int totalSets,
    int totalReps,
    String elapsedStr,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: AppAssets.of(context)!.totalVolumeLabel,
                value: _fmtVolume(totalVolume),
                unit: 'kg',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: AppAssets.of(context)!.durationLabel,
                value: elapsedStr,
                unit: '',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: AppAssets.of(context)!.totalSetsLabel,
                value: '$totalSets',
                unit: AppAssets.of(context)!.setsUnit(totalSets),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: AppAssets.of(context)!.totalRepsLabel,
                value: '$totalReps',
                unit: AppAssets.of(context)!.repsUnit(totalReps),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.unit,
  });

  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.grey, fontSize: 12),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    color: AppColors.monoWhite,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: const TextStyle(color: AppColors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseLogCard extends StatelessWidget {
  const _ExerciseLogCard({required this.exercise});

  final WorkoutExerciseState exercise;

  String _fmt(double w) => w % 1 == 0 ? '${w.toInt()}' : '$w';

  @override
  Widget build(BuildContext context) {
    final sets = exercise.sets;

    var maxWeight = 0.0;
    var maxReps = 0;
    for (final s in sets) {
      if (s.weight > maxWeight) {
        maxWeight = s.weight;
        maxReps = s.reps;
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white10,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.exercise.name,
                      style: const TextStyle(
                        color: AppColors.monoWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppAssets.of(context)!.exerciseSetSummary(
                        sets.length,
                        _fmt(maxWeight),
                        maxReps,
                      ),
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white12),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(
                width: 40,
                child: Text(
                  'No.',
                  style: TextStyle(color: AppColors.grey, fontSize: 12),
                ),
              ),
              Expanded(
                child: Text(
                  AppAssets.of(context)!.weightHeader,
                  style: const TextStyle(color: AppColors.grey, fontSize: 12),
                ),
              ),
              Expanded(
                child: Text(
                  'rep',
                  style: const TextStyle(color: AppColors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ...sets.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '${entry.key + 1}',
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${_fmt(entry.value.weight)}kg',
                      style: const TextStyle(
                        color: AppColors.monoWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${entry.value.reps}rep',
                      style: const TextStyle(
                        color: AppColors.monoWhite,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
