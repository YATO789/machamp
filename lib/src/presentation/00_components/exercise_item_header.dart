import 'package:flutter/material.dart';
import 'package:machamp/src/core/constants/app_color.dart';

class ExerciseItemHeader extends StatelessWidget {
  const ExerciseItemHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isExpanded,
    this.trailingAction,
  });

  final String title;
  final String subtitle;
  final bool isExpanded;
  final Widget? trailingAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  title,
                  style: const TextStyle(
                    color: AppColors.monoWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          if (trailingAction != null) trailingAction!,
          Icon(
            isExpanded
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            color: Colors.grey,
            size: 20,
          ),
        ],
      ),
    );
  }
}
