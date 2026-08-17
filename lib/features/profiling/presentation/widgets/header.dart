import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

class Header extends StatelessWidget {
  final String title;
  final String subTitle;

  const Header({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .center,
      children: [
        Text(
          title,
          style: AppTypography.displayMed.copyWith(
            color: AppColors.textPrimary500,
          ),
        ),

        const SizedBox(height: AppSizes.s8),

        Text(
          subTitle,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textBody500,
          ),
        ),
      ]
    );
  }
}
