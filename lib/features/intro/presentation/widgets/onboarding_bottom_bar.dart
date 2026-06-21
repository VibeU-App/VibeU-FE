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
        Spacing.s24,
        Spacing.s8,
        Spacing.s24,
        Spacing.s32,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SKIP button (text only, hidden on last page)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isLastPage ? 0.0 : 1.0,
            child: TextButton(
              onPressed: isLastPage ? null : onSkip,
              child: Text(
                'SKIP',
                style: AppTypography.button.copyWith(
                  color: AppColors.textMuted400,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),

          // Next button: circle FAB on pages 1&2, filled rect on last page
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
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
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary500,
          shape: BoxShape.circle,
          boxShadow: AppShadows.mid,
        ),
        child: const Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
          size: 24,
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
          horizontal: Spacing.s24,
          vertical: Spacing.s16,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary500,
          borderRadius: BorderRadius.circular(Radius.r12),
          boxShadow: AppShadows.mid,
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
