import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';

class PasswordRequirementsBox extends StatelessWidget {
  final bool hasMinLength;
  final bool hasNumber;
  final bool hasSpecialChar;

  const PasswordRequirementsBox({
    super.key,
    this.hasMinLength = false,
    this.hasNumber = false,
    this.hasSpecialChar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.s4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Spacing.s8),
        border: Border.all(color: AppColors.surface600),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Password requirements:', style: AppTypography.bodyStd.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: Spacing.s8),
          _buildRequirementItem('At least 8 characters long', isMet: hasMinLength),
          const SizedBox(height: Spacing.s8),
          _buildRequirementItem('Contains at least one number', isMet: hasNumber),
          const SizedBox(height: Spacing.s8),
          _buildRequirementItem('Contains at least one special character', isMet: hasSpecialChar),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text, {required bool isMet}) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle_outlined,
          size: 16,
          color: isMet ? Colors.green : AppColors.secondary400,
        ),
        const SizedBox(width: Spacing.s4),
        Text(text, style: AppTypography.button.copyWith(color: AppColors.secondary400)),
      ],
    );
  }
}
