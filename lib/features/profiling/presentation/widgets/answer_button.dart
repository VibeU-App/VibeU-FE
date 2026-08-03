import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

class AnswerButton extends HookWidget {
  const AnswerButton({
    super.key,
    required this.index,
    required this.answer,
    required this.selected,
    required this.onPressed,
  });

  final int index;
  final bool selected;
  final String answer;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      transitionBuilder: (widget, animation) {
        return FadeTransition(
          opacity: animation,
          child: widget,
        );
      },
      child: GestureDetector(
        key: ValueKey('answers_${index}_${selected}'),
        onTap: onPressed,
        child: Container(
          width: .infinity,
          margin: const .symmetric(vertical: AppSizes.s16),
          padding: const .all(AppSizes.s16),
          decoration: BoxDecoration(
            borderRadius: const .all(.circular(AppSizes.s8)),
            border: .all(color: AppColors.surface600),
            color: selected
              ? AppColors.background500
              : Color(0xb2ffffff),
          ),
          child: Row(
            crossAxisAlignment: .start,
            children: [
              _Circle(value: selected),
              const SizedBox(width: AppSizes.s16),
              Expanded(
                child: Text(
                  answer,
                  style: AppTypography.h3.copyWith(color: Colors.black)
                )
              )
            ]
          )
        )
      )
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({
    required this.value,
  });

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.s16,
      width: AppSizes.s16,
      decoration: BoxDecoration(
        borderRadius: const .all(.circular(AppSizes.r999)),
        border: .all(color: Colors.black),
        color: value
          ? AppColors.primary300
          : AppColors.background50,
      )
    );
  }
}
