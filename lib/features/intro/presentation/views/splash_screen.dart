import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'onboarding_view.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;

  // 1. Tạo biến state để điều khiển việc chuyển đổi
  bool _showFullCombo = false;
  @override
  void initState() {
    super.initState();
    // 🎬 NHỊP 1: Giữ Native Splash 1 giây cho app ổn định background
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (!mounted) return;

      // 🎬 NHỊP 2: Gỡ Native Splash ra, lộ ra Logo trơn của Flutter
      FlutterNativeSplash.remove();

      // 🎬 NHỊP 3: Đợi 200ms rồi bắt đầu chạy hiệu ứng Cross-Fade (Fade chéo) biến hình logo
      Future.delayed(const Duration(milliseconds: 900), () {
        if (!mounted) return;
        setState(() {
          _showFullCombo = true; // Kích hoạt đổi ảnh sang cụm đầy đủ
        });
      });

      // 🎬 NHỊP 4: Đợi hiện combo đầy đủ xong xuôi (khoảng 2.5 giây), rồi nhảy sang Onboarding liền
      Future.delayed(const Duration(milliseconds: 3500), () {
        if (!mounted) return;

        // Đoạn code điều hướng thần thánh của ông đã quay trở lại đây!
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, _, _) => const OnboardingView(),
            transitionsBuilder: (_, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background50,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 🛑 ẢNH 1: LOGO TRƠN (Chìm xuống và mờ đi)
            AnimatedScale(
              // Khi biến hình, nó sẽ thu nhỏ lại còn 80% (0.8)
              scale: _showFullCombo ? 0.8 : 1.0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOutBack, // Hiệu ứng có độ nhún nhẹ
              child: AnimatedOpacity(
                opacity: _showFullCombo ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 600),
                child: Image.asset(
                  'assets/images/splash_flutter_native.webp',
                  width: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // 🚀 ẢNH 2: COMBO ĐẦY ĐỦ (Trượt từ dưới lên, nở ra và sáng lên)
            AnimatedSlide(
              // Bắt đầu ở vị trí thấp hơn một chút (Offset Y = 0.15), sau đó trượt lên tâm (0)
              offset: _showFullCombo ? Offset.zero : const Offset(0, 0.15),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCubic, // Trượt lên mượt và giảm tốc tinh tế
              child: AnimatedScale(
                // Bắt đầu từ 90% (0.9), nở to ra 100% (1.0)
                scale: _showFullCombo ? 1.0 : 0.9,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutCubic,
                child: AnimatedOpacity(
                  opacity: _showFullCombo ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: Image.asset(
                    'assets/images/splash_screen.webp',
                    width: 280,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
