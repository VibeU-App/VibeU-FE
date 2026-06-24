import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/ui/app_colors.dart';

BoxDecoration backgroundGradient() => BoxDecoration(
  gradient: LinearGradient (
    colors: <Color>[
    AppColors.surface500,
    AppColors.background500,
  ],
  begin: .topCenter,
  end: .bottomCenter,
  )
);
