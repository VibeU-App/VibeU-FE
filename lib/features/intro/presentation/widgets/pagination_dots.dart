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
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: Spacing.s4),
          width: isActive ? 24.0 : 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary500 : AppColors.textMuted300,
            borderRadius: BorderRadius.circular(Radius.r999),
          ),
        );
      }),
    );
  }
}
