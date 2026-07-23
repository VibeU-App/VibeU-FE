import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:vibeu_fe/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const double logoSmall = 80.0;
  static const double logoLarge = 134.0;
  static const double logoRetract = 110.0;
  bool _isZoomed = false; // Trạng thái phóng to logo
  bool _showText = false; // Trạng thái hiện chữ

  @override
  void initState() {
    super.initState();
    _initSplash();
  }

  Future<void> _initSplash() async {
    // 1. Giữ Native Splash 800ms
    await Future.delayed(AppDurations.normal);
    if (!mounted) return;

    // 2. Gỡ Native Splash
    FlutterNativeSplash.remove();

    // 3. HIỆU ỨNG ZOOM: Phóng to logo lên 134x133
    setState(() {
      _isZoomed = true;
    });

    // 4. Đợi logo phóng to xong (khoảng 1s) thì bắt đầu hiện chữ
    await Future.delayed(AppDurations.slow);
    if (!mounted) return;
    
    setState(() {
      _showText = true;
    });

    // 5. Đợi hiện chữ xong rồi qua Onboarding
    await Future.delayed(AppDurations.splashDelay);
    if (!mounted) return;

    context.go(Routes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background500,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- LOGO ANIMATION ---
              AnimatedContainer(
                duration: AppDurations.slow,
                curve: Curves.easeOutBack, // Hiệu ứng có độ nhún nhẹ khi phóng to
                // Bắt đầu từ size icon nhỏ (khoảng 80), phóng to lên 134, 
                // sau khi hiện chữ thì thu lại 110 cho cân đối
                width: _showText ? logoRetract : (_isZoomed ? logoLarge : logoSmall),
                height: _showText ? logoRetract : (_isZoomed ? logoLarge : logoSmall),
                child: Image.asset(
                  AppAssets.splashLogo,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: AppSizes.s16),

              // --- TEXT ANIMATION ---
              AnimatedOpacity(
                duration: AppDurations.normal,
                opacity: _showText ? 1.0 : 0.0,
                child: AnimatedSlide(
                  duration: AppDurations.normal,
                  offset: _showText ? Offset.zero : const Offset(0, 0.5),
                  curve: Curves.easeOutCubic,
                  child: Column(
                    children: [
                      Text(
                        'VibeU',
                        style: AppTypography.displayMed.copyWith(
                          color: AppColors.primary500,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.s32 + AppSizes.s8,
                        ),
                      ),
                      const SizedBox(height: AppSizes.s4),
                      Text(
                        'Match Your Vibe',
                        style: AppTypography.bodyStd.copyWith(
                          color: AppColors.secondary500,
                          fontWeight: FontWeight.w600,
                          fontSize: AppSizes.s16 + AppSizes.s4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
