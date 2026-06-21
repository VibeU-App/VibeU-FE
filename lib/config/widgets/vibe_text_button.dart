import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';

class VibeTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const VibeTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [AppShadows.low],
          borderRadius: BorderRadius.circular(Radius.r8),
        ),
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary500,
            elevation: 0,
          ),
          child: Text(
            text,
            style: AppTypography.h2.copyWith(
              color: AppColors.textBody50,
            )
          ),
        )
      );
    }
}
