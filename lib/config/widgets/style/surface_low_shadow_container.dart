import 'package:flutter/material.dart';

import '../../ui/design_system.dart';

class SurfaceLowShadowContainer extends StatelessWidget {
  final Widget child;

  const SurfaceLowShadowContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface500,
        boxShadow: [AppShadows.low],
        borderRadius: BorderRadius.circular(AppSizes.r8),
      ),
      child: child,
    );
  }
}
