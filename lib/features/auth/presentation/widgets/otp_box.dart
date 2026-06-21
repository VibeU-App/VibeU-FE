import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';

class OtpBox extends StatelessWidget {
  final String? num;
  final bool focused;
  final Widget animatedCursor;
  
  const OtpBox({
    super.key,
    required this.num,
    required this.focused,
    required this.animatedCursor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      alignment: .center,
      decoration: BoxDecoration(
        borderRadius: .circular(Radius.r8),
        border: .all(
          color: focused ? AppColors.primary500: AppColors.surface600
        ),
      ),
      child: focused ? animatedCursor :
        num != null ? Text(num!, style: AppTypography.button) :
        null,
    );
  }
}
