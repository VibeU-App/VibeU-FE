import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final int strengthLevel;

  const PasswordStrengthIndicator({
    super.key,
    this.strengthLevel = 1, 
  });

  @override
  Widget build(BuildContext context) {
    String strengthText = 'weak';
    Color strengthColor = Colors.red;

    
    if (strengthLevel == 2) {
      strengthText = 'fair';
      strengthColor = Colors.orange;
    } else if (strengthLevel >= 3) {
      strengthText = 'strong';
      strengthColor = Colors.green;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Password Strength', style: AppTypography.bodyStd.copyWith(color: AppColors.textMuted300)),
            Text(strengthText, style: AppTypography.bodyStd.copyWith(color: strengthColor))
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            _buildStrengthBar(isActive: strengthLevel >= 1, color: strengthColor),
            const SizedBox(width: 8),
            _buildStrengthBar(isActive: strengthLevel >= 2, color: strengthColor),
            const SizedBox(width: 8),
            _buildStrengthBar(isActive: strengthLevel >= 3, color: strengthColor),
            const SizedBox(width: 8),
            _buildStrengthBar(isActive: strengthLevel >= 4, color: strengthColor),
          ],
        ),
      ],
    );
  }

  Widget _buildStrengthBar({required bool isActive, required Color color}) {
    return Expanded(
      child: Container(
        height: 4,
        decoration: BoxDecoration(
          color: isActive ? color : AppColors.surface600,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
