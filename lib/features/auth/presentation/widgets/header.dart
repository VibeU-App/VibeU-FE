import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/ui/design_system.dart';

class Header extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool alignCenter;
  final bool showBrand;

  const Header({
    super.key,
    required this.title,
    required this.subTitle,
    this.alignCenter = false,
    this.showBrand = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignCenter ? .center : .start,
      children: [
        if (showBrand)...[
          Image.asset('assets/images/vibeu.webp', height: 96.0),
        ],
        Text(
          title,
          style: AppTypography.displayMed.copyWith(
            color: AppColors.primary500,
          ),
          textAlign: alignCenter ? .center : null,
        ),

        SizedBox(height: 6.0),

        Text(
          subTitle,
          style: (showBrand ? AppTypography.bodyStd : AppTypography.bodySmall)
          .copyWith(
            color: AppColors.textPrimary500,
          ),
          textAlign: alignCenter ? .center : null,
        ),
      ]
    );
  }
}
