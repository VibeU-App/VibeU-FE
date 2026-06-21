import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;

  // configurations specified in Figma documentation
  final double loginButtonHeight = 48.0;

  const SocialLoginButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
    Widget build(BuildContext context) {
      return Container(
        width: double.infinity,
        height: loginButtonHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Radius.r8),
        ),
        child: OutlinedButton.icon(
          label: Text(label, style: AppTypography.bodyStd.copyWith(
            color: AppColors.textBody400,
          )),
          icon: icon,
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.surface500,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.surface700),
              borderRadius: BorderRadius.circular(Radius.r8),
            ),
          ),
        )
      );
    }
}
