import 'package:flutter/material.dart';

import 'app_theme_extension.dart';
import 'app_typography.dart';

// insert this in main.dart
// like this:
/*
void main() {
  ...
  runApp(MaterialApp(
    ...
    theme: AppTheme.theme, <==
    ...
  ));
  ...
}
*/
// then use it in build() with Theme.of(context).extension<AppColors>();
class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,

      textTheme: TextTheme(
        bodyLarge: AppTypography.bodyLead,
        bodyMedium: AppTypography.bodyStd,
        bodySmall: AppTypography.bodySmall,
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMed,
        headlineLarge: AppTypography.h1,
        headlineMedium: AppTypography.h2,
        headlineSmall: AppTypography.h3,
        labelLarge: AppTypography.button,
        labelMedium: AppTypography.caption,
        labelSmall: AppTypography.overline,
      ),

      extensions: [AppThemeExtension()],
    );
  }
}

