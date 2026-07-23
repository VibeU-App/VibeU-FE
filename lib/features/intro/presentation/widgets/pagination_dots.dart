import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

class PaginationDots extends StatelessWidget {
  final int totalPages;
  final int currentPage;

  const PaginationDots({
    super.key,
    required this.totalPages,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: AppDurations.fast,
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.s4),
          width: isActive ? AppSizes.s24 : AppSizes.s8,
          height: AppSizes.s8,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary500 : AppColors.textMuted300,
            borderRadius: BorderRadius.circular(AppSizes.r999),
          ),
        );
      }),
    );
  }
}
