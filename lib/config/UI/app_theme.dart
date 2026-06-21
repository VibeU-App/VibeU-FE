import 'package:flutter/material.dart';
import 'design_system.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // 1. Cấu hình hệ màu hệ thống (ColorScheme)
      scaffoldBackgroundColor: AppColors.background50,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary500,
        secondary: AppColors.secondary500,
        surface: AppColors.surface50,
        onPrimary:
            AppColors.surface50, // Màu chữ hiển thị TRÊN nền Primary (Trắng)
        onSurface:
            AppColors.textBody500, // Màu chữ mặc định hiển thị trên nền app
      ),

      // 2.RÁP FULL TEXT THEME VÀO ĐÂY
      textTheme: TextTheme(
        //  Nhóm Display (Chữ siêu bự ở Banner/Splash)
        displayLarge: AppTypography.displayLarge.copyWith(
          color: AppColors.textPrimary500,
        ),
        displayMedium: AppTypography.displayMed.copyWith(
          color: AppColors.textPrimary500,
        ),

        //  Nhóm Headings (Tiêu đề màn hình, tên cụm chức năng)
        headlineLarge: AppTypography.h1.copyWith(
          color: AppColors.textPrimary500,
        ),
        headlineMedium: AppTypography.h2.copyWith(
          color: AppColors.textPrimary500,
        ),
        headlineSmall: AppTypography.h3.copyWith(
          color: AppColors.textPrimary500,
        ),

        //  Nhóm Body (Đoạn văn văn bản, tin nhắn chat)
        bodyLarge: AppTypography.bodyLead.copyWith(
          color: AppColors.textBody500,
        ),
        bodyMedium: AppTypography.bodyStd.copyWith(
          color: AppColors.textBody500,
        ),
        bodySmall: AppTypography.bodySmall.copyWith(
          color: AppColors.textMuted500,
        ),

        //  Nhóm Labels (Dành cho Nút bấm, Chú thích Caption, Overline)
        labelLarge: AppTypography.button.copyWith(color: AppColors.textBody500),
        labelMedium: AppTypography.caption.copyWith(
          color: AppColors.textMuted500,
        ),
        labelSmall: AppTypography.overline.copyWith(
          color: AppColors.textMuted500,
        ),
      ),
    );
  }
}
