import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/app_colors.dart';
import 'package:vibeu_fe/config/UI/app_sizes.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final bool wrapWithScaffold;

  const BackgroundGradient({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSizes.s24),
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.wrapWithScaffold = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = SafeArea(
      top: safeAreaTop,
      bottom: safeAreaBottom,
      child: child,
    );

    if (wrapWithScaffold) {
      content = Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: content,
      );
    }

    return Container(
      padding: padding,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.surface500,
            AppColors.background500,
          ],
          begin: .topCenter,
          end: .bottomCenter,
        ),
      ),
      child: content,
    );
  }
}
