import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/domain/entity/exercise_set.dart';
import 'package:machamp/src/domain/entity/menu_exercise.dart';

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({
    super.key,
    required this.menuExercise,
    required this.isExpanded,
    required this.isEditable,
    required this.onTap,
    this.exerciseIndex,
    this.onDelete,
    this.onSetCountChanged,
    this.onSetChanged,
    this.leading,
  });

  final MenuExercise menuExercise;
  final bool isExpanded;
  final bool isEditable;
  final VoidCallback onTap;
  final int? exerciseIndex;
  final VoidCallback? onDelete;
  final ValueChanged<int>? onSetCountChanged;
  final void Function(int setIndex, ExerciseSet updated)? onSetChanged;
  final Widget? leading;

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
                  if (leading != null)
                    GestureDetector(
                      onTap: () {},
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: leading,
                      ),
                    ),
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
                  if (isEditable && isExpanded)
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: onDelete,
                    ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                    size: 20,
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
                    if (isEditable) ...[
                      Row(
                        children: [
                          const Text(
                            'セット数',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          const Spacer(),
                          _CounterButton(
                            icon: Icons.remove,
                            onPressed: () => onSetCountChanged?.call(
                              menuExercise.sets.length - 1,
                            ),
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
                            onPressed: () => onSetCountChanged?.call(
                              menuExercise.sets.length + 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                    const SetTableHeader(),
                    ...List.generate(menuExercise.sets.length, (setIndex) {
                      return _SetRow(
                        key: isEditable
                            ? ValueKey('${exerciseIndex ?? 0}-$setIndex')
                            : null,
                        setNumber: setIndex + 1,
                        exerciseSet: menuExercise.sets[setIndex],
                        onChanged: isEditable
                            ? (updated) => onSetChanged?.call(setIndex, updated)
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
  late TextEditingController _intervalController;

  @override
  void initState() {
    super.initState();
    _repsController = TextEditingController(
      text: widget.exerciseSet.reps.toString(),
    );
    _weightController = TextEditingController(
      text: _formatWeight(widget.exerciseSet.weight),
    );
    _intervalController = TextEditingController(
      text: widget.exerciseSet.intervalSeconds.toString(),
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
    final currentInterval = int.tryParse(_intervalController.text) ?? 0;
    if (widget.exerciseSet.intervalSeconds != currentInterval) {
      _intervalController.text = widget.exerciseSet.intervalSeconds.toString();
    }
  }

  @override
  void dispose() {
    _repsController.dispose();
    _weightController.dispose();
    _intervalController.dispose();
    super.dispose();
  }

  String _formatWeight(double w) =>
      w % 1 == 0 ? w.toInt().toString() : w.toString();

  @override
  Widget build(BuildContext context) {
    final isEditable = widget.onChanged != null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              '${widget.setNumber}',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Expanded(
            child: isEditable
                ? _NumberField(
                    controller: _weightController,
                    allowDecimal: true,
                    onChanged: (v) {
                      final weight = double.tryParse(v);
                      if (weight != null) {
                        widget.onChanged!(
                          widget.exerciseSet.copyWith(weight: weight),
                        );
                      }
                    },
                  )
                : _ReadOnlyCell(text: _formatWeight(widget.exerciseSet.weight)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: isEditable
                ? _NumberField(
                    controller: _repsController,
                    onChanged: (v) {
                      final reps = int.tryParse(v);
                      if (reps != null) {
                        widget.onChanged!(
                          widget.exerciseSet.copyWith(reps: reps),
                        );
                      }
                    },
                  )
                : _ReadOnlyCell(text: '${widget.exerciseSet.reps}'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: isEditable
                ? _NumberField(
                    controller: _intervalController,
                    onChanged: (v) {
                      final interval = int.tryParse(v);
                      if (interval != null) {
                        widget.onChanged!(
                          widget.exerciseSet.copyWith(
                            intervalSeconds: interval,
                          ),
                        );
                      }
                    },
                  )
                : _ReadOnlyCell(
                    text: '${widget.exerciseSet.intervalSeconds}',
                  ),
          ),
        ],
      ),
    );
  }
}

class _ReadOnlyCell extends StatelessWidget {
  const _ReadOnlyCell({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.monoWhite, fontSize: 14),
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

class SetTableHeader extends StatelessWidget {
  const SetTableHeader({super.key});

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
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              '重量(kg)',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              'レップ数',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              'インターバル(秒)',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
