import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;

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
        height: AppSizes.s48,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(AppSizes.r8)),
        ),
        child: OutlinedButton.icon(
          label: Text(label, style: AppTypography.bodyStd.copyWith(
            color: AppColors.textBody400,
          )),
          icon: icon,
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.surface500,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: AppColors.surface700),
              borderRadius: BorderRadius.all(Radius.circular(AppSizes.r8)),
            ),
          ),
        )
      );
    }
}
