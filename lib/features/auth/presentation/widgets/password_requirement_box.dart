import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'surface_low_shadow_container.dart';

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
    return SurfaceLowShadowContainer(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text('Password requirements:', style: AppTypography.bodyStd.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSizes.s8),
          _buildRequirementItem('At least 8 characters long', isMet: hasMinLength),
          const SizedBox(height: AppSizes.s8),
          _buildRequirementItem('Contains at least one number', isMet: hasNumber),
          const SizedBox(height: AppSizes.s8),
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
          color: isMet ? Colors.green : AppColors.primary500,
        ),
        const SizedBox(width: AppSizes.s4),
        Text(text, style: AppTypography.caption),
      ],
    );
  }
}
