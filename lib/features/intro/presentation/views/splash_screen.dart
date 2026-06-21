import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';
import 'onboarding_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // After 2.5s, fade out then navigate to onboarding
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      _controller.reverse().then((_) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const OnboardingView(),
            transitionsBuilder: (_, animation, __, child) {
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
      body: FadeTransition(
        opacity: _fadeIn,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo V
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary500,
                    width: 3,
                  ),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    'V',
                    style: AppTypography.displayLarge.copyWith(
                      color: AppColors.primary500,
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Spacing.s16),
              // VibeU
              Text(
                'VibeU',
                style: AppTypography.displayLarge.copyWith(
                  color: AppColors.textPrimary500,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: Spacing.s4),
              // Slogan
              Text(
                'Match Your Vibe',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted500,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
