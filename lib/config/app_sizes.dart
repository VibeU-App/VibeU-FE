import 'package:flutter/material.dart';

/// Chứa các hằng số về khoảng cách (Padding, Margin, SizedBox)
/// Sử dụng hệ thống lưới 4px (4px baseline grid)
class Spacing {
  static const double s4 = 4.0;
  static const double s8 = 8.0;
  static const double s16 = 16.0;
  static const double s24 = 24.0;
  static const double s32 = 32.0;
  static const double s48 = 48.0;
  static const double s64 = 64.0;
}

///Chứa các hằng số về độ bo góc (Border Radius)
class Radius {
  static const double r4 = 4.0; // Dùng cho: Checkboxes
  static const double r8 =
      8.0; // Dùng cho: Standard input (Ô nhập liệu), chat text (Khung chat)
  static const double r12 =
      12.0; // Dùng cho: Action button (Nút bấm), small card (Thẻ nhỏ)
  static const double r20 =
      20.0; // Dùng cho: Profile swipe card (Thẻ quẹt profile VibeU)
  static const double r32 =
      32.0; // Dùng cho: Bottom sheet (Bảng kéo từ dưới lên)
  static const double r999 =
      999.0; // Dùng cho: Avatars (Ảnh đại diện tròn), Status Chips

  //Tiện ích hỗ trợ gọi nhanh BorderRadius trong code UI
  static BorderRadius circular(double radius) => BorderRadius.circular(radius);
}
