import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/app_colors.dart';
import 'package:vibeu_fe/config/UI/app_sizes.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const BackgroundGradient({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSizes.s24),
  });

  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: child,
        ),
      )
    );
  }
}
