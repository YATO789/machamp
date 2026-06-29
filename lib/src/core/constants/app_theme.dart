import 'package:flutter/material.dart';
import 'package:machamp/src/core/constants/app_color.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.black,
  colorScheme: ColorScheme.dark(
    primary: AppColors.purple,
    surface: AppColors.darkSurface,
    onPrimary: AppColors.monoWhite,
    onSurface: AppColors.monoWhite,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.black,
    foregroundColor: AppColors.monoWhite,
    elevation: 0,
  ),
);
