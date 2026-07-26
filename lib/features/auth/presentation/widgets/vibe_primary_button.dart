import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

class VibePrimaryButton extends StatelessWidget {
  final String text;
  final Future<void> Function() onPressed;
  final Widget? icon;
  final bool running;

  const VibePrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.running = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      height: 49.0,
      decoration: const BoxDecoration(
        borderRadius: .all(.circular(AppSizes.r8)),
      ),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary500,
          shape: const RoundedRectangleBorder(
            borderRadius: .all(.circular(AppSizes.r8)),
          ),
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Opacity(
              opacity: 0.0,
              child: running ?
                CircularProgressIndicator(value: 0.0)
                :
                icon,
            ),
            const SizedBox.square(dimension: AppSizes.s16),
            Text(
              text,
              style: AppTypography.button.copyWith(
                color: AppColors.textBody50,
              )
            ),
            const SizedBox.square(dimension: AppSizes.s16),
            Container(child: running ?
              CircularProgressIndicator(color: AppColors.textBody50)
              : icon
            ),
          ]
        )
      )
    );
  }
}
