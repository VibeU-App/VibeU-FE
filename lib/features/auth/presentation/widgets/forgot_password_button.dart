import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/app_colors.dart';
import 'package:vibeu_fe/config/themes/app_typography.dart';

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ForgotPasswordButton({
    super.key,
    required this.onPressed,
  });

  @override
    Widget build(BuildContext context) {
      return Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            'Forgot Password?',
            style: AppTypography.bodyStd.copyWith(
              color: AppColors.textPrimary500,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.textPrimary500,
              decorationStyle: TextDecorationStyle.solid,
              // why text not bold enough
            ),
          ),
        )
      );
    }
}
