import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

class PaginationBars extends StatelessWidget {
  final int page;
  final int totalPage;
  
  const PaginationBars({
    super.key,
    required this.page,
    required this.totalPage,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Column(
        key: ValueKey(page),
        children: [
          Row(
            key: ValueKey('page_$page'),
            children: List.generate(totalPage, (int index) => Expanded(
              child: Container(
                height: AppSizes.s4,
                decoration: BoxDecoration(
                  borderRadius: const .all(.circular(AppSizes.r999)),
                  color: page >= index ? AppColors.textPrimary500 : AppColors.surface700,
                ),
                margin: .only(
                  left: index > 0 ? AppSizes.s4 : 0,
                  right: index < totalPage - 1 ? AppSizes.s4 : 0,
                )
              )
            ))
          )
        ]
      )
    );
  }
}
