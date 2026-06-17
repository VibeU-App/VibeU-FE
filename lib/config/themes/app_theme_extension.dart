import 'package:flutter/material.dart';

import 'app_colors.dart';

// DesignSystem could be a better sounding name
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  // 1. PRIMARY COLORS (Màu Chủ Đạo - Đỏ Hồng)
  final Color primary50 = AppColors.primary50;
  final Color primary100 = AppColors.primary100;
  final Color primary200 = AppColors.primary200;
  final Color primary300 = AppColors.primary300;
  final Color primary400 = AppColors.primary400;
  final Color primary500 = AppColors.primary500;
  final Color primary600 = AppColors.primary600;
  final Color primary700 = AppColors.primary700;
  final Color primary800 = AppColors.primary800;
  final Color primary900 = AppColors.primary900;

  // 2. SECONDARY COLORS (Màu Phụ)
  final Color secondary50 = AppColors.secondary50;
  final Color secondary100 = AppColors.secondary100;
  final Color secondary200 = AppColors.secondary200;
  final Color secondary300 = AppColors.secondary300;
  final Color secondary400 = AppColors.secondary400;
  final Color secondary500 = AppColors.secondary500;
  final Color secondary600 = AppColors.secondary600;
  final Color secondary700 = AppColors.secondary700;
  final Color secondary800 = AppColors.secondary800;
  final Color secondary900 = AppColors.secondary900;

  // CTA
  final Color cta50 = AppColors.cta50;
  final Color cta100 = AppColors.cta100;
  final Color cta200 = AppColors.cta200;
  final Color cta300 = AppColors.cta300;
  final Color cta400 = AppColors.cta400;
  final Color cta500 = AppColors.cta500;
  final Color cta600 = AppColors.cta600;
  final Color cta700 = AppColors.cta700;
  final Color cta800 = AppColors.cta800;
  final Color cta900 = AppColors.cta900;

  //ACCENT
  final Color accent50 = AppColors.accent50;
  final Color accent100 = AppColors.accent100;
  final Color accent200 = AppColors.accent200;
  final Color accent300 = AppColors.accent300;
  final Color accent400 = AppColors.accent400;
  final Color accent500 = AppColors.accent500;
  final Color accent600 = AppColors.accent600;
  final Color accent700 = AppColors.accent700;
  final Color accent800 = AppColors.accent800;
  final Color accent900 = AppColors.accent900;

  // Background
  final Color background50 = AppColors.background50;
  final Color background100 = AppColors.background100;
  final Color background200 = AppColors.background200;
  final Color background300 = AppColors.background300;
  final Color background400 = AppColors.background400;
  final Color background500 = AppColors.background500;
  final Color background600 = AppColors.background600;
  final Color background700 = AppColors.background700;
  final Color background800 = AppColors.background800;
  final Color background900 = AppColors.background900;

  // Surface
  final Color surface50 = AppColors.surface50;
  final Color surface100 = AppColors.surface100;
  final Color surface200 = AppColors.surface200;
  final Color surface300 = AppColors.surface300;
  final Color surface400 = AppColors.surface400;
  final Color surface500 = AppColors.surface500;
  final Color surface600 = AppColors.surface600;
  final Color surface700 = AppColors.surface700;
  final Color surface800 = AppColors.surface800;
  final Color surface900 = AppColors.surface900;

  // Text Primary
  final Color textPrimary50 = AppColors.textPrimary50;
  final Color textPrimary100 = AppColors.textPrimary100;
  final Color textPrimary200 = AppColors.textPrimary200;
  final Color textPrimary300 = AppColors.textPrimary300;
  final Color textPrimary400 = AppColors.textPrimary400;
  final Color textPrimary500 = AppColors.textPrimary500;
  final Color textPrimary600 = AppColors.textPrimary600;
  final Color textPrimary700 = AppColors.textPrimary700;
  final Color textPrimary800 = AppColors.textPrimary800;
  final Color textPrimary900 = AppColors.textPrimary900;

  // Text Body
  final Color textBody50 = AppColors.textBody50;
  final Color textBody100 = AppColors.textBody100;
  final Color textBody200 = AppColors.textBody200;
  final Color textBody300 = AppColors.textBody300;
  final Color textBody400 = AppColors.textBody400;
  final Color textBody500 = AppColors.textBody500;
  final Color textBody600 = AppColors.textBody600;
  final Color textBody700 = AppColors.textBody700;
  final Color textBody800 = AppColors.textBody800;
  final Color textBody900 = AppColors.textBody900;

  // Text Muted
  final Color textMuted50 = AppColors.textMuted50;
  final Color textMuted100 = AppColors.textMuted100;
  final Color textMuted200 = AppColors.textMuted200;
  final Color textMuted300 = AppColors.textMuted300;
  final Color textMuted400 = AppColors.textMuted400;
  final Color textMuted500 = AppColors.textMuted500;
  final Color textMuted600 = AppColors.textMuted600;
  final Color textMuted700 = AppColors.textMuted700;
  final Color textMuted800 = AppColors.textMuted800;
  final Color textMuted900 = AppColors.textMuted900;

  @override ThemeExtension<AppThemeExtension> copyWith() {
    // TODO: implement copyWith
    return this;
  }

  @override ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t
  ) {
    // TODO: implement lerp
    return this;
  }
}
