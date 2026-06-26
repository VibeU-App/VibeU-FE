import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';

class VibePrimaryButton extends StatelessWidget {
  final String text;
  final Future<void> Function() onPressed;
  final Widget? icon;
  final IconAlignment? iconAlignment;

  const VibePrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconAlignment,
  });

  @override
    Widget build(BuildContext context) {
      return Container(
        width: double.infinity,
        height: 49.0,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(AppSizes.r8)),
        ),
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: icon,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary500,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.r8),
            ),
            iconAlignment: iconAlignment,
          ),
          label: Text(
            text,
            style: AppTypography.h2.copyWith(
              color: AppColors.textBody50,
            )
          ),
        )
      );
    }
}
