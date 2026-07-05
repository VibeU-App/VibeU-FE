import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';

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
            Opacity(child: running ?
              CircularProgressIndicator(value: 0.0)
              :
              icon,
              opacity: 0.0,
            ),
            const SizedBox.square(dimension: 15.22),
            Text(
              text,
              style: AppTypography.button.copyWith(
                color: AppColors.textBody50,
              )
            ),
            const SizedBox.square(dimension: 15.22),
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
