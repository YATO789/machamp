import 'package:flutter/material.dart';
import 'package:machamp/src/core/constants/app_color.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.fontSize = 15,
    this.iconSize,
  });

  final T value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T> onChanged;
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
      child: DropdownButton<T>(
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
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(itemLabel(item)),
              ),
            )
            .toList(),
        onChanged: (v) => onChanged(v as T),
      ),
    );
  }
}
