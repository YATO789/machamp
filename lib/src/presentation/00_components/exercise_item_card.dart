import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/domain/entity/exercise_set.dart';
import 'package:machamp/src/domain/entity/menu_exercise.dart';

class ExerciseItemCard extends StatelessWidget {
  const ExerciseItemCard({
    super.key,
    required this.menuExercise,
    required this.isExpanded,
    this.exerciseIndex = 0,
    this.onTap,
    this.onDelete,
    this.onSetCountChanged,
    this.onSetChanged,
  });

  final MenuExercise menuExercise;
  final bool isExpanded;
  final int exerciseIndex;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final ValueChanged<int>? onSetCountChanged;
  final void Function(int setIndex, ExerciseSet updated)? onSetChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menuExercise.exercise.name,
                          style: const TextStyle(
                            color: AppColors.monoWhite,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${menuExercise.sets.length}セット',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isExpanded && onDelete != null)
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: onDelete,
                    ),
                ],
              ),
            ),
            if (isExpanded) ...[
              const Divider(color: Colors.white12, height: 1),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    if (onSetCountChanged != null) ...[
                      Row(
                        children: [
                          const Text(
                            'セット数',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          const Spacer(),
                          _CounterButton(
                            icon: Icons.remove,
                            onPressed: () =>
                                onSetCountChanged!(menuExercise.sets.length - 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '${menuExercise.sets.length}',
                              style: const TextStyle(
                                color: AppColors.monoWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _CounterButton(
                            icon: Icons.add,
                            onPressed: () =>
                                onSetCountChanged!(menuExercise.sets.length + 1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                    const _SetTableHeader(),
                    ...List.generate(menuExercise.sets.length, (setIndex) {
                      return _SetRow(
                        key: ValueKey('$exerciseIndex-$setIndex'),
                        setNumber: setIndex + 1,
                        exerciseSet: menuExercise.sets[setIndex],
                        onChanged: onSetChanged != null
                            ? (updated) => onSetChanged!(setIndex, updated)
                            : null,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: AppColors.monoWhite, size: 18),
      ),
    );
  }
}

class _SetTableHeader extends StatelessWidget {
  const _SetTableHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              'No.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              'レップ数',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              '重量(kg)',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _SetRow extends StatefulWidget {
  const _SetRow({
    super.key,
    required this.setNumber,
    required this.exerciseSet,
    this.onChanged,
  });

  final int setNumber;
  final ExerciseSet exerciseSet;
  final ValueChanged<ExerciseSet>? onChanged;

  @override
  State<_SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<_SetRow> {
  late TextEditingController _repsController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _repsController =
        TextEditingController(text: widget.exerciseSet.reps.toString());
    _weightController = TextEditingController(
      text: _formatWeight(widget.exerciseSet.weight),
    );
  }

  @override
  void didUpdateWidget(covariant _SetRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentReps = int.tryParse(_repsController.text) ?? 0;
    if (widget.exerciseSet.reps != currentReps) {
      _repsController.text = widget.exerciseSet.reps.toString();
    }
    final currentWeight = double.tryParse(_weightController.text) ?? 0.0;
    if (widget.exerciseSet.weight != currentWeight) {
      _weightController.text = _formatWeight(widget.exerciseSet.weight);
    }
  }

  @override
  void dispose() {
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  String _formatWeight(double w) =>
      w % 1 == 0 ? w.toInt().toString() : w.toString();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              '${widget.setNumber}',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          if (widget.onChanged != null) ...[
            Expanded(
              child: _NumberField(
                controller: _repsController,
                onChanged: (v) {
                  final reps = int.tryParse(v);
                  if (reps != null) {
                    widget.onChanged!(widget.exerciseSet.copyWith(reps: reps));
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _NumberField(
                controller: _weightController,
                allowDecimal: true,
                onChanged: (v) {
                  final weight = double.tryParse(v);
                  if (weight != null) {
                    widget.onChanged!(
                        widget.exerciseSet.copyWith(weight: weight));
                  }
                },
              ),
            ),
          ] else ...[
            Expanded(
              child: Text(
                '${widget.exerciseSet.reps}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.monoWhite, fontSize: 14),
              ),
            ),
            Expanded(
              child: Text(
                _formatWeight(widget.exerciseSet.weight),
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.monoWhite, fontSize: 14),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.controller,
    required this.onChanged,
    this.allowDecimal = false,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool allowDecimal;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
        fillColor: Colors.white10,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
