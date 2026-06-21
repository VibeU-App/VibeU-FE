import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';

class VibePrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon;
  final IconAlignment? iconAlignment;

  // configurations specified in the Figma documentation
  final double primaryButtonHeight = 49.0;

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
        height: primaryButtonHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Radius.r8),
        ),
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: icon,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary500,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Radius.r8),
            ),
            iconAlignment: iconAlignment,
          ),
          label: Text(
            text,
            style: AppTypography.bodyLead.copyWith(
              color: AppColors.textBody50,
            )
          ),
        )
      );
    }
}
