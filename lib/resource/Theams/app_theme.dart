import 'package:city_hub/resource/Theams/color_palette.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: .light,
  colorScheme: ColorScheme.light(
    surface: AppColors.lightBackground,
    primary: AppColors.lightPrimary,
    secondary: AppColors.lightSecondary,
  )
);


ThemeData darkMode = ThemeData(
  brightness: .dark,
  colorScheme: ColorScheme.dark(
    surface: AppColors.darkBackground,
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary
  )

);