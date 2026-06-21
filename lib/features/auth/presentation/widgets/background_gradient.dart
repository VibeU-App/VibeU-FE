import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/themes/app_colors.dart';

class BackgroundGradient {
  static BoxDecoration get gradient => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color> [
        AppColors.surface500,
        AppColors.background500,
      ]
    )
  );
}
