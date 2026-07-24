import 'package:flutter/material.dart';
import 'package:machamp/src/core/constants/app_color.dart';

class SetCountControl extends StatelessWidget {
  const SetCountControl({
    super.key,
    required this.count,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int count;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CountButton(icon: Icons.remove, onTap: onDecrement),
        const SizedBox(width: 8),
        _CountButton(icon: Icons.add, onTap: onIncrement),
      ],
    );
  }
}

class _CountButton extends StatelessWidget {
  const _CountButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: enabled
              ? AppColors.monoWhite
              : AppColors.monoWhite.withValues(alpha: 0.3),
          size: 18,
        ),
      ),
    );
  }
}
