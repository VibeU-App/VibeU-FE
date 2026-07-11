import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import '../views/onboarding_view.dart';
import 'pagination_dots.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final int currentPage;
  final int totalPages;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topSectionHeight = screenHeight * 0.48;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ── TOP SECTION: curved background + images ──
        SizedBox(
          height: topSectionHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Curved background
              ClipPath(
                clipper: _CurvedBottomClipper(),
                child: Container(
                  width: double.infinity,
                  height: topSectionHeight,
                  color: AppColors.background300,
                ),
              ),
              // Top image (centered)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 48,
                      bottom: 40,
                      left: AppSizes.s24,
                      right: AppSizes.s24,
                    ),
                    child: Image.asset(
                      data.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSizes.s48),

        // ── PAGINATION DOTS ──
        PaginationDots(
          totalPages: totalPages,
          currentPage: currentPage,
        ),

        const SizedBox(height: AppSizes.s24),

        // ── TITLE ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s32),
          child: Text(
            data.title,
            textAlign: TextAlign.center,
            style: AppTypography.displayLarge.copyWith(
              color: AppColors.primary500,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ),

        const SizedBox(height: AppSizes.s16),

        // ── DESCRIPTION ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s32),
          child: Text(
            data.description,
            textAlign: TextAlign.center,
            style: AppTypography.bodyStd.copyWith(
              color: AppColors.textMuted500,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom clipper tạo viền cong úp ngược ở đáy section trên
class _CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 40,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_CurvedBottomClipper oldClipper) => false;
}
