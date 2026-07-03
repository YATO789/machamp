import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/presentation/00_components/primary_button.dart';
import 'package:machamp/src/presentation/workout/workout_view_model.dart';
import 'package:machamp/src/router/router.dart';

class WorkoutScreen extends HookConsumerWidget {
  const WorkoutScreen({super.key, required this.menuId});

  final String menuId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workoutViewModelProvider(menuId));
    final vm = ref.read(workoutViewModelProvider(menuId).notifier);
    final isSaving = useState(false);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(state.menuName.isEmpty ? 'ワークアウト' : state.menuName),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.exercises.length,
                itemBuilder: (context, exerciseIndex) {
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
                              GestureDetector(
                                onTap: () =>
                                    vm.toggleExerciseCompleted(exerciseIndex),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: exercise.isCompleted
                                        ? AppColors.purple
                                        : AppColors.white10,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: exercise.isCompleted
                                      ? const Icon(
                                          Icons.check,
                                          color: AppColors.monoWhite,
                                          size: 20,
                                        )
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  exercise.exercise.name,
                                  style: const TextStyle(
                                    color: AppColors.monoWhite,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ...List.generate(exercise.sets.length, (setIndex) {
                            final set = exercise.sets[setIndex];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: _WorkoutSetRow(
                                key: ValueKey('$exerciseIndex-$setIndex'),
                                setNumber: setIndex + 1,
                                isCurrent: false,
                                initialWeight: set.weight,
                                initialReps: set.reps,
                                isCompleted: set.isCompleted,
                                onWeightChanged: (w) => vm.updateSetWeight(
                                  exerciseIndex,
                                  setIndex,
                                  w,
                                ),
                                onRepsChanged: (r) => vm.updateSetReps(
                                  exerciseIndex,
                                  setIndex,
                                  r,
                                ),
                                onToggleCompleted: () => vm.toggleSetCompleted(
                                  exerciseIndex,
                                  setIndex,
                                ),
                              ),
                            );
                          }),
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
                  label: isSaving.value ? '保存中...' : '終了',
                  onPressed: isSaving.value
                      ? null
                      : () async {
                          final hasIncomplete = state.exercises.any(
                            (ex) => ex.sets.any((s) => !s.isCompleted),
                          );
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('ワークアウトを終了しますか？'),
                              content: hasIncomplete
                                  ? const Text('チェックされていないセットは記録されません。')
                                  : null,
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(false),
                                  child: const Text('キャンセル'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(true),
                                  child: const Text('終了'),
                                ),
                              ],
                            ),
                          );
                          if (confirmed != true || !context.mounted) return;

                          final anyCompleted = state.exercises.any(
                            (ex) => ex.sets.any((s) => s.isCompleted),
                          );
                          if (!anyCompleted) {
                            context.go(AppRoutes.home.path);
                            return;
                          }

                          isSaving.value = true;
                          try {
                            await vm.saveWorkout(menuId);
                          } catch (e, st) {
                            debugPrint('saveWorkout error: $e\n$st');
                            isSaving.value = false;
                            if (!context.mounted) return;
                            await showDialog<void>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('保存に失敗しました'),
                                content: Text('$e'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }
                          isSaving.value = false;

                          if (!context.mounted) return;
                          final hasCompleted = state.exercises.any(
                            (ex) => ex.sets.any((s) => s.isCompleted),
                          );
                          if (hasCompleted) {
                            await context.push(
                              '/menu/$menuId/workout/summary',
                              extra: state,
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
    required this.onWeightChanged,
    required this.onRepsChanged,
    required this.onToggleCompleted,
  });

  final int setNumber;
  final bool isCurrent;
  final double initialWeight;
  final int initialReps;
  final bool isCompleted;
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(10),
        ),
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
            const Text(
              '×',
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
              onTap: widget.onToggleCompleted,
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
        ),
        onChanged: onChanged,
      ),
    );
  }
}
