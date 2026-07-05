import 'package:flutter/material.dart';

import '../themes/design_system.dart';

class SurfaceLowShadowContainer extends StatelessWidget {
  final Widget child;

  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Alignment? alignment;

  const SurfaceLowShadowContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.surface500,
        boxShadow: [AppShadows.low],
        borderRadius: BorderRadius.circular(AppSizes.r8),
      ),
      child: child,
    );
  }
}
