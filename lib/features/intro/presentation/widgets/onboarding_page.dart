import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import '../views/onboarding_view.dart';
import 'pagination_dots.dart';

class OnboardingPage extends StatefulWidget {
  final OnboardingData data;
  final int currentPage;
  final int totalPages;
  static const double imageBottomRatio = 0.035;
  static const double headerHeightRatio = 0.55;
  static const double curveHeightRatio = 0.14;

  // define ratio
  static const double swipingOffsetRatio = 0.07;
  static const double matchingOffsetRatio = -0.005;
  static const double connectingOffsetRatio = -0.01;
  const OnboardingPage({
    super.key,
    required this.data,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.normal,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(OnboardingPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.data != widget.data) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    final topSectionHeight = (screenHeight * OnboardingPage.headerHeightRatio).clamp(420.0, 500.0);
    final curveHeight = (screenHeight * OnboardingPage.curveHeightRatio).clamp(115.0, 145.0);

    double imageScale;
    Offset imageOffset;

    switch (widget.data.title) {
      case 'SWIPING':
        imageScale = 1.08;
        imageOffset = Offset(0, screenHeight * OnboardingPage.swipingOffsetRatio);
        break;

      case 'MATCHING':
        imageScale = 1.50;
        imageOffset = Offset(0, -screenHeight * OnboardingPage.matchingOffsetRatio);
        break;

      case 'CONNECTING':
        imageScale = 0.82;
        imageOffset = Offset(0, -screenHeight * OnboardingPage.connectingOffsetRatio);
        break;

      default:
        imageScale = 1.0;
        imageOffset = Offset.zero;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRect(
          child: SizedBox(
            height: topSectionHeight,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Container(
                  width: double.infinity,
                  height: topSectionHeight,
                  color: AppColors.background300,
                ),

                Positioned.fill(
                  bottom: screenHeight * OnboardingPage.imageBottomRatio,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Align(
                        alignment: Alignment.center,
                        child: Transform.translate(
                          offset: imageOffset,
                          child: Transform.scale(
                            scale: imageScale,
                            child: Image.asset(
                              widget.data.imagePath,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -1,
                  child: CustomPaint(
                    size: Size(screenWidth, curveHeight),
                    painter: _CurvePainter(color: AppColors.surface50),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: AppSizes.s16),

        FadeTransition(
          opacity: _opacityAnimation,
          child: PaginationDots(
            totalPages: widget.totalPages,
            currentPage: widget.currentPage,
          ),
        ),

        const SizedBox(height: AppSizes.s32),

        Expanded(
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.s32,
                    ),
                    child: Text(
                      widget.data.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.fredoka(
                        fontSize: AppSizes.s32 + AppSizes.s4,
                        fontWeight: FontWeight.w700,
                        letterSpacing: AppTypography.titleLetterSpacing,
                        height: AppTypography.titleLineHeight,
                        color: AppColors.primary500,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSizes.s16),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.s32,
                    ),
                    child: Text(
                      widget.data.description,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyStd.copyWith(
                        color: AppColors.textMuted500,
                        height: AppTypography.descriptionLineHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CurvePainter extends CustomPainter {
  final Color color;
  static const double startPointYRatio = 0.20;
  static const double controlPointXRatio1 = 0.25;
  static const double controlPointXRatio2 = 0.75;
  static const double bottomCurveRatio = 1.1;
  _CurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final path = Path();

    // Sửa các con số ở đây để viền hồng cong đẹp hơn
    path.moveTo(0, size.height * startPointYRatio);

    path.cubicTo(
      size.width * controlPointXRatio1,
      size.height * bottomCurveRatio,
      size.width * controlPointXRatio2,
      size.height * bottomCurveRatio,
      size.width,
      size.height * startPointYRatio,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}