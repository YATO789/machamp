import 'package:flutter/material.dart';
import 'package:machamp/src/core/constants/app_color.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.fontSize = 15,
    this.iconSize,
  });

  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final double fontSize;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: AppColors.darkSurface,
        style: TextStyle(color: AppColors.monoWhite, fontSize: fontSize),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.grey,
          size: iconSize,
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }
}
