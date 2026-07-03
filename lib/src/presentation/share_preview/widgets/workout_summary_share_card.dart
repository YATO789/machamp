import 'dart:io';

import 'package:flutter/material.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/core/constants/date_format_utils.dart';

String commaFormat(String value) {
  final parts = value.split('.');
  final intPart = parts[0];
  final reversed = intPart.split('').reversed.toList();
  final buf = <String>[];
  for (var i = 0; i < reversed.length; i++) {
    if (i > 0 && i % 3 == 0) buf.add(',');
    buf.add(reversed[i]);
  }
  final formatted = buf.reversed.join();
  return parts.length > 1 ? '$formatted.${parts[1]}' : formatted;
}

class WorkoutSummaryShareCard extends StatelessWidget {
  const WorkoutSummaryShareCard({
    super.key,
    required this.backgroundImage,
    required this.workoutName,
    required this.totalVolume,
    required this.totalSets,
    required this.date,
    required this.durationMinutes,
  });

  final File backgroundImage;
  final String workoutName;
  final String totalVolume;
  final int totalSets;
  final DateTime date;
  final int durationMinutes;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(backgroundImage, fit: BoxFit.cover),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.35, 0.75],
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.88),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 36,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formatShareDate(date),
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  workoutName,
                  style: const TextStyle(
                    color: AppColors.monoWhite,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _ShareStatItem(
                      label: 'Volume',
                      value: commaFormat(totalVolume),
                      unit: 'kg',
                    ),
                    const SizedBox(width: 36),
                    _ShareStatItem(
                      label: 'Duration',
                      value: '$durationMinutes',
                      unit: 'min',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          'M',
                          style: TextStyle(
                            color: AppColors.monoWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Machamp',
                      style: TextStyle(
                        color: AppColors.monoWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareStatItem extends StatelessWidget {
  const _ShareStatItem({
    required this.label,
    required this.value,
    required this.unit,
  });

  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.monoWhite.withValues(alpha: 0.7),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 2),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  color: AppColors.monoWhite,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              TextSpan(
                text: ' $unit',
                style: TextStyle(
                  color: AppColors.monoWhite.withValues(alpha: 0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
