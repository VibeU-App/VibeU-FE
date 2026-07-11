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
  // 1. Tạo biến state để điều khiển việc chuyển đổi
  bool _showFullCombo = false;

  @override
  void initState() {
    super.initState();
    // Native flutter: Giữ Native Splash 1 giây cho app ổn định background
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;

      // Splash screen: Gỡ Native Splash ra, lộ ra Logo trơn của Flutter
      FlutterNativeSplash.remove();

      // Đợi 500ms rồi bắt đầu chạy hiệu ứng Cross-Fade (Fade chéo) biến hình logo
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        setState(() {
          _showFullCombo = true; // Kích hoạt đổi ảnh sang cụm đầy đủ
        });
      });

      // Đợi hiện combo đầy đủ xong xuôi, rồi nhảy sang Onboarding liền
      Future.delayed(const Duration(milliseconds: 3500), () {
        if (!mounted) return;

        context.go(Routes.onboarding);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background50,
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 🛑 ẢNH 1: LOGO TRƠN (Chìm xuống và mờ đi)
              AnimatedScale(
                scale: _showFullCombo ? 0.8 : 1.0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOutBack,
                child: AnimatedOpacity(
                  opacity: _showFullCombo ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 600),
                  child: Image.asset(
                    AppAssets.splashNative,
                    width: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // 🚀 ẢNH 2: COMBO ĐẦY ĐỦ (Trượt từ dưới lên, nở ra và sáng lên)
              AnimatedSlide(
                offset: _showFullCombo ? Offset.zero : const Offset(0, 0.15),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutCubic,
                child: AnimatedScale(
                  scale: _showFullCombo ? 1.0 : 0.9,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOutCubic,
                  child: AnimatedOpacity(
                    opacity: _showFullCombo ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    child: Image.asset(
                      AppAssets.splashLogo,
                      width: 280,
                      fit: BoxFit.contain,
                    ),
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
