import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Nhớ cài "flutter pub add google_fonts" trong terminal để lấy front Google
class AppTypography {
  // --- DISPLAY ---
  static TextStyle  displayLarge = GoogleFonts.outfit(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 48 / 40,
  );
  static TextStyle  displayMed = GoogleFonts.fredoka(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 40 / 32,
  );

  // --- HEADING ---
  static TextStyle  h1 = GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 32 / 24,
  );
  static TextStyle  h2 = GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
  );
  static TextStyle  h3 = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
  );

  // --- BODY ---
  static TextStyle  bodyLead = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 28 / 18,
  );
  static TextStyle  bodyStd = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  );
  static TextStyle  bodySmall = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
  );

  // --- COMPONENTS ---
  static TextStyle  button = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 16 / 16,
  );
  static TextStyle  caption = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
  );
  static TextStyle  overline = GoogleFonts.plusJakartaSans(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    height: 12 / 11,
  );
  static const double titleLetterSpacing = 1.4;
  static const double titleLineHeight = 1.1;
  static const double buttonLetterSpacing = 1.5;
  static const double descriptionLineHeight = 1.6;
}