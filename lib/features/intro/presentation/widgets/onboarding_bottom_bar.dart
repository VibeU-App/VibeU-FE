import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

class OnboardingBottomBar extends StatelessWidget {
  final bool isLastPage;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  const OnboardingBottomBar({
    super.key,
    required this.isLastPage,
    required this.onSkip,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.s24,
        AppSizes.s8,
        AppSizes.s24,
        AppSizes.s32,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SKIP button (secondary300)
          AnimatedOpacity(
            duration: AppDurations.fast,
            opacity: isLastPage ? 0.0 : 1.0,
            child: TextButton(
              onPressed: isLastPage ? null : onSkip,
              child: Text(
                'SKIP',
                style: AppTypography.button.copyWith(
                  color: AppColors.secondary300,
                  fontWeight: FontWeight.w700,
                  fontSize:AppSizes.s24,
                  letterSpacing: AppTypography.buttonLetterSpacing,
                ),
              ),
            ),
          ),

          // Next button (secondary500)
          AnimatedSwitcher(
            duration: AppDurations.fast,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: isLastPage
                ? _GetStartedButton(key: const ValueKey('get_started'), onPressed: onNext)
                : _NextCircleButton(key: const ValueKey('next'), onPressed: onNext),
          ),
        ],
      ),
    );
  }
}

class _NextCircleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _NextCircleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: AppSizes.s48 + AppSizes.s8,
        height: AppSizes.s48 + AppSizes.s8,
        decoration: BoxDecoration(
          color: AppColors.secondary500, // Đổi sang secondary500 theo yêu cầu mới
          shape: BoxShape.circle,
          boxShadow: [AppShadows.mid],
        ),
        child: const Icon(
          Icons.chevron_right_rounded,
          color: Colors.white,
          size: AppSizes.s32,
        ),
      ),
    );
  }
}

class _GetStartedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _GetStartedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.s24,
          vertical: AppSizes.s16,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary500,
          borderRadius: BorderRadius.circular(AppSizes.r12),
          boxShadow: [AppShadows.mid],
        ),
        child: Text(
          'Get Started!',
          style: AppTypography.button.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
