import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadows {
  static BoxShadow low = BoxShadow(
    color: AppColors.textPrimary500.withValues(alpha: 0.16),
    blurRadius: 4,
    offset: const Offset(0, 2),
  );

  static BoxShadow mid = BoxShadow(
    color: AppColors.textPrimary500.withValues(alpha: 0.20),
    blurRadius: 8,
    spreadRadius: -4,
    offset: const Offset(0, 8),
  );

  static BoxShadow high = BoxShadow(
    color: AppColors.textPrimary500.withValues(alpha: 0.24),
    blurRadius: 32,
    spreadRadius: -8,
    offset: const Offset(0, 20),
  );
}