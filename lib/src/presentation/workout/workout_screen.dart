import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/localization/app_assets.dart';
import 'package:machamp/src/presentation/00_components/keyboard_done_bar.dart';
import 'package:machamp/src/presentation/00_components/primary_button.dart';
import 'package:machamp/src/presentation/00_components/set_count_control.dart';
import 'package:machamp/src/presentation/activity_log/activity_log_view_model.dart';
import 'package:machamp/src/presentation/menu_editor/exercise_selection/exercise_selection_sheet.dart';
import 'package:machamp/src/presentation/workout/workout_view_model.dart';
import 'package:machamp/src/router/router.dart';

class WorkoutScreen extends HookConsumerWidget {
  const WorkoutScreen({super.key, required this.menuId});

  final String menuId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workoutViewModelProvider(menuId));
    final notifier = ref.read(workoutViewModelProvider(menuId).notifier);
    final isSaving = useState(false);
    final elapsed = useState(Duration.zero);
    final timerVisible = useState(true);
    final intervalRemaining = useState<int?>(null);
    final intervalTotal = useState<int>(0);
    final intervalTimerRef = useRef<Timer?>(null);

    useEffect(() {
      final startedAt = state.startedAt;
      if (startedAt == null) return null;
      elapsed.value = DateTime.now().difference(startedAt);
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        elapsed.value = DateTime.now().difference(startedAt);
      });
      return timer.cancel;
    }, [state.startedAt]);

    useEffect(() {
      return () => intervalTimerRef.value?.cancel();
    }, const []);

    void startIntervalTimer(int seconds) {
      intervalTimerRef.value?.cancel();
      intervalTotal.value = seconds;
      intervalRemaining.value = seconds;
      intervalTimerRef.value = Timer.periodic(const Duration(seconds: 1), (t) {
        final rem = intervalRemaining.value;
        if (rem == null || rem <= 1) {
          t.cancel();
          intervalTimerRef.value = null;
          intervalRemaining.value = null;
        } else {
          intervalRemaining.value = rem - 1;
        }
      });
    }

    void dismissTimer() {
      intervalTimerRef.value?.cancel();
      intervalTimerRef.value = null;
      intervalRemaining.value = null;
    }

    void adjustIntervalTimer(int delta) {
      final rem = intervalRemaining.value;
      if (rem == null) return;
      final newRem = rem + delta;
      if (newRem <= 0) {
        dismissTimer();
        return;
      }
      intervalRemaining.value = newRem;
      intervalTotal.value = intervalTotal.value + delta;
    }

    String formatElapsed(Duration d) {
      final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
      final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$m:$s';
    }

    final isIntervalActive = intervalRemaining.value != null;

    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            state.menuName.isEmpty
                ? AppAssets.of(context)!.workoutFallbackTitle
                : state.menuName,
          ),
          actions: [
            GestureDetector(
              onTap: () => timerVisible.value = !timerVisible.value,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    timerVisible.value ? formatElapsed(elapsed.value) : '--:--',
                    style: const TextStyle(
                      color: AppColors.monoWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.opaque,
          child: KeyboardDoneBar(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.exercises.length + 1,
                        itemBuilder: (context, exerciseIndex) {
                          if (exerciseIndex == state.exercises.length) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: PrimaryButton(
                                label: AppAssets.of(context)!.addExercise,
                                onPressed: () {
                                  unawaited(
                                    showModalBottomSheet<void>(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (_) => ExerciseSelectionSheet(
                                        onAdd: notifier.addExercises,
                                      ),
                                    ),
                                  );
                                },
                                variant: PrimaryButtonVariant.ghost,
                                icon: Icons.add,
                              ),
                            );
                          }
                          final exercise = state.exercises[exerciseIndex];
                          return Opacity(
                            opacity: exercise.isCompleted ? 0.5 : 1.0,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          exercise.exercise.name,
                                          style: const TextStyle(
                                            color: AppColors.monoWhite,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      SetCountControl(
                                        count: exercise.sets.length,
                                        onDecrement: exercise.sets.length > 1
                                            ? () => notifier.removeSet(
                                                exerciseIndex,
                                              )
                                            : null,
                                        onIncrement: exercise.sets.length < 10
                                            ? () =>
                                                  notifier.addSet(exerciseIndex)
                                            : null,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      //color: AppColors.darkSurface,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: List.generate(
                                        exercise.sets.length,
                                        (setIndex) {
                                          final set = exercise.sets[setIndex];
                                          return _WorkoutSetRow(
                                            key: ValueKey(
                                              '$exerciseIndex-$setIndex',
                                            ),
                                            setNumber: setIndex + 1,
                                            isCurrent: false,
                                            initialWeight: set.weight,
                                            initialReps: set.reps,
                                            isCompleted: set.isCompleted,
                                            isIntervalActive: isIntervalActive,
                                            onWeightChanged: (w) =>
                                                notifier.updateSetWeight(
                                                  exerciseIndex,
                                                  setIndex,
                                                  w,
                                                ),
                                            onRepsChanged: (r) =>
                                                notifier.updateSetReps(
                                                  exerciseIndex,
                                                  setIndex,
                                                  r,
                                                ),
                                            onToggleCompleted: () {
                                              if (!set.isCompleted &&
                                                  set.intervalSeconds > 0) {
                                                startIntervalTimer(
                                                  set.intervalSeconds,
                                                );
                                              }
                                              notifier.toggleSetCompleted(
                                                exerciseIndex,
                                                setIndex,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: PrimaryButton(
                          label: isSaving.value
                              ? AppAssets.of(context)!.saving
                              : AppAssets.of(context)!.end,
                          onPressed: isSaving.value
                              ? null
                              : () async {
                                  final hasIncomplete = state.exercises.any(
                                    (ex) => ex.sets.any((s) => !s.isCompleted),
                                  );
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: Text(
                                          AppAssets.of(ctx)!.endWorkoutTitle,
                                        ),
                                        content: hasIncomplete
                                            ? Text(
                                                AppAssets.of(
                                                  ctx,
                                                )!.uncheckedSetsWarning,
                                              )
                                            : null,
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(ctx).pop(false),
                                            child: Text(
                                              AppAssets.of(ctx)!.cancel,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(ctx).pop(true),
                                            child: Text(AppAssets.of(ctx)!.end),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (confirmed != true || !context.mounted) {
                                    return;
                                  }

                                  final anyCompleted = state.exercises.any(
                                    (ex) => ex.sets.any((s) => s.isCompleted),
                                  );
                                  if (!anyCompleted) {
                                    context.go(AppRoutes.home.path);
                                    return;
                                  }

                                  isSaving.value = true;
                                  try {
                                    await notifier.saveWorkout(menuId);
                                    ref.invalidate(activityLogProvider);
                                  } catch (e, st) {
                                    debugPrint('saveWorkout error: $e\n$st');
                                    isSaving.value = false;
                                    if (!context.mounted) return;
                                    await showDialog<void>(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          title: Text(
                                            AppAssets.of(ctx)!.saveFailed,
                                          ),
                                          content: Text('$e'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(),
                                              child: Text(
                                                AppAssets.of(ctx)!.ok,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    return;
                                  }
                                  isSaving.value = false;

                                  if (!context.mounted) return;
                                  final savedState = ref.read(
                                    workoutViewModelProvider(menuId),
                                  );
                                  final hasCompleted = savedState.exercises.any(
                                    (ex) => ex.sets.any((s) => s.isCompleted),
                                  );
                                  if (hasCompleted) {
                                    await context.push(
                                      '/menu/$menuId/workout/summary',
                                      extra: savedState,
                                    );
                                  } else {
                                    context.go('/home');
                                  }
                                },
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedSlide(
                    offset: isIntervalActive ? Offset.zero : const Offset(0, 1),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: _IntervalTimerBar(
                      remaining: intervalRemaining.value ?? 0,
                      total: intervalTotal.value,
                      onDismiss: dismissTimer,
                      onAdjust: adjustIntervalTimer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IntervalTimerBar extends StatelessWidget {
  const _IntervalTimerBar({
    required this.remaining,
    required this.total,
    required this.onDismiss,
    required this.onAdjust,
  });

  final int remaining;
  final int total;
  final VoidCallback onDismiss;
  final void Function(int delta) onAdjust;

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? remaining / total : 0.0;
    final m = (remaining ~/ 60).toString().padLeft(2, '0');
    final s = (remaining % 60).toString().padLeft(2, '0');

    return Container(
      color: AppColors.darkSurface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.grey),
                    onPressed: onDismiss,
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () => onAdjust(-10),
                    child: const Text(
                      '-10秒',
                      style: TextStyle(color: AppColors.grey, fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '$m:$s',
                        style: const TextStyle(
                          color: AppColors.monoWhite,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => onAdjust(10),
                    child: const Text(
                      '+10秒',
                      style: TextStyle(color: AppColors.grey, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: AppColors.white10,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.purple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkoutSetRow extends StatefulWidget {
  const _WorkoutSetRow({
    super.key,
    required this.setNumber,
    required this.isCurrent,
    required this.initialWeight,
    required this.initialReps,
    required this.isCompleted,
    required this.isIntervalActive,
    required this.onWeightChanged,
    required this.onRepsChanged,
    required this.onToggleCompleted,
  });

  final int setNumber;
  final bool isCurrent;
  final double initialWeight;
  final int initialReps;
  final bool isCompleted;
  final bool isIntervalActive;
  final ValueChanged<double> onWeightChanged;
  final ValueChanged<int> onRepsChanged;
  final VoidCallback onToggleCompleted;

  @override
  State<_WorkoutSetRow> createState() => _WorkoutSetRowState();
}

class _WorkoutSetRowState extends State<_WorkoutSetRow> {
  late TextEditingController _weightController;
  late TextEditingController _repsController;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(
      text: _formatWeight(widget.initialWeight),
    );
    _repsController = TextEditingController(
      text: widget.initialReps.toString(),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  String _formatWeight(double w) =>
      w % 1 == 0 ? w.toInt().toString() : w.toString();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.isCompleted ? 0.5 : 1.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Text(
                '${widget.setNumber}',
                style: TextStyle(
                  color: widget.isCurrent
                      ? AppColors.purple
                      : AppColors.monoWhite,
                  fontSize: 14,
                  fontWeight: widget.isCurrent
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _NumberInputField(
              controller: _weightController,
              allowDecimal: true,
              onChanged: (v) {
                final w = double.tryParse(v);
                if (w != null) widget.onWeightChanged(w);
              },
            ),
            const SizedBox(width: 6),
            const Text(
              'kg',
              style: TextStyle(color: AppColors.grey, fontSize: 13),
            ),
            const SizedBox(width: 8),
            _NumberInputField(
              controller: _repsController,
              allowDecimal: false,
              onChanged: (v) {
                final r = int.tryParse(v);
                if (r != null) widget.onRepsChanged(r);
              },
            ),
            const SizedBox(width: 6),
            const Text(
              'rep',
              style: TextStyle(color: AppColors.grey, fontSize: 13),
            ),
            const Spacer(),
            GestureDetector(
              onTap: widget.isIntervalActive ? null : widget.onToggleCompleted,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: widget.isCompleted
                      ? AppColors.purple
                      : Colors.transparent,
                  border: Border.all(
                    color: widget.isCompleted
                        ? AppColors.purple
                        : Colors.white30,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: widget.isCompleted
                    ? const Icon(
                        Icons.check,
                        color: AppColors.monoWhite,
                        size: 16,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberInputField extends StatelessWidget {
  const _NumberInputField({
    required this.controller,
    required this.onChanged,
    this.allowDecimal = false,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool allowDecimal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: Colors.transparent,
          ),
        ),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.monoWhite, fontSize: 14),
          keyboardType: allowDecimal
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.number,
          inputFormatters: [
            if (allowDecimal)
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
            else
              FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white10,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppColors.purple, width: 1.5),
            ),
          ),
          onTap: () {
            controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: controller.text.length,
            );
          },
          onChanged: onChanged,
        ),
      ),
    );
  }
}
