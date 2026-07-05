import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String _text;
  final Color _color;
  final int strengthLevel;

  const PasswordStrengthIndicator._(this.strengthLevel, String text, Color color)
  : _text = text, _color = color;

  factory PasswordStrengthIndicator({required int strengthLevel}) {
    switch(strengthLevel) {
      case 0:
        return PasswordStrengthIndicator._(strengthLevel, '', AppColors.surface600);
      case 1:
        return PasswordStrengthIndicator._(strengthLevel, 'weak', AppColors.primary500);
      case 2:
        return PasswordStrengthIndicator._(strengthLevel, 'fair', Colors.orange);
      case 3:
        return PasswordStrengthIndicator._(strengthLevel, 'strong', Colors.green);
      case 4:
        return PasswordStrengthIndicator._(strengthLevel, 'very strong', Color(0xff02590f));
      default:
        throw Exception('bad strength value specified');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Column(
        key: ValueKey(strengthLevel),
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text('Password Strength', style: AppTypography.bodyStd.copyWith(color: AppColors.textMuted300)),
              Text(_text, style: AppTypography.bodyStd.copyWith(color: _color))
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            key: ValueKey('bars_$strengthLevel'),
            children: List.generate(4, (int index) => Expanded(
              child: Container(
                height: 4.0,
                decoration: BoxDecoration(
                  borderRadius: const .all(.circular(AppSizes.r999)),
                  color: strengthLevel > index ? _color : AppColors.surface600,
                ),
                margin: .only(
                  left: index > 0 ? 4 : 0,
                  right: index < 3 ? 4 : 0,
                )
              )
            ))
          )
        ]
      )
    );
  }
}
