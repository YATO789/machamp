import 'package:flutter/material.dart';
import 'package:machamp/src/core/constants/app_color.dart';

class CalendarBottomSheet extends StatefulWidget {
  const CalendarBottomSheet({
    super.key,
    required this.selectedDate,
    required this.workoutDates,
    required this.onDateSelected,
  });

  final DateTime selectedDate;
  final Set<DateTime> workoutDates;
  final ValueChanged<DateTime> onDateSelected;

  static Future<void> show({
    required BuildContext context,
    required DateTime selectedDate,
    required Set<DateTime> workoutDates,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => CalendarBottomSheet(
        selectedDate: selectedDate,
        workoutDates: workoutDates,
        onDateSelected: onDateSelected,
      ),
    );
  }

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  late DateTime _displayMonth;
  late DateTime _selected;

  static const _weekLabels = ['月', '火', '水', '木', '金', '土', '日'];
  static const _accent = AppColors.purple;

  @override
  void initState() {
    super.initState();
    _displayMonth = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
    );
    _selected = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_displayMonth.year}年 ${_displayMonth.month}月',
                    style: const TextStyle(
                      color: AppColors.monoWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          color: AppColors.monoWhite,
                        ),
                        onPressed: () => setState(() {
                          _displayMonth = DateTime(
                            _displayMonth.year,
                            _displayMonth.month - 1,
                          );
                        }),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.chevron_right,
                          color: AppColors.monoWhite,
                        ),
                        onPressed: () => setState(() {
                          _displayMonth = DateTime(
                            _displayMonth.year,
                            _displayMonth.month + 1,
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: _weekLabels
                    .map(
                      (label) => Expanded(
                        child: Center(
                          child: Text(
                            label,
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildGrid(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    final firstDay = DateTime(_displayMonth.year, _displayMonth.month, 1);
    final offset = firstDay.weekday - 1;
    final daysInMonth = DateTime(
      _displayMonth.year,
      _displayMonth.month + 1,
      0,
    ).day;
    final rows = ((offset + daysInMonth) / 7).ceil();

    return Column(
      children: List.generate(rows, (row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: List.generate(7, (col) {
              final dayNum = row * 7 + col - offset + 1;
              if (dayNum < 1 || dayNum > daysInMonth) {
                return const Expanded(child: SizedBox(height: 44));
              }
              final date = DateTime(
                _displayMonth.year,
                _displayMonth.month,
                dayNum,
              );
              final isSelected = date == _selected;
              final hasWorkout = widget.workoutDates.contains(date);

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onDateSelected(date);
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: isSelected
                            ? const BoxDecoration(
                                color: _accent,
                                shape: BoxShape.circle,
                              )
                            : null,
                        child: Center(
                          child: Text(
                            '$dayNum',
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.black
                                  : AppColors.monoWhite,
                              fontSize: 15,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: hasWorkout ? _accent : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}
