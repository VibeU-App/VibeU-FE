import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/ui/app_typography.dart';
import 'package:vibeu_fe/config/ui/app_colors.dart';

class SignUpButton extends StatelessWidget{
  final VoidCallback onPressed;

  const SignUpButton({
    super.key,
    required this.onPressed,
  });

  @override
    Widget build(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account?',
            style: AppTypography.button.copyWith(color: AppColors.textMuted500)
          ),

          TextButton(
            onPressed: onPressed,
            child: Text(
              'Sign Up',
              style: AppTypography.button.copyWith(color: AppColors.textPrimary500),
            )
          )
        ],
      );
    }
}
