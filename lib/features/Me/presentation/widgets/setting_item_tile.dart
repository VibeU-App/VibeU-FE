import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

class SettingItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingItemTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.r8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.s16),
        child: Row(
          children: [
            // Container cùng kích thước CircleAvatar(radius: s16) = s32 × s32
            SizedBox(
              width: AppSizes.s32,
              height: AppSizes.s32,
              child: Center(
                child: Icon(icon, size: AppSizes.s24, color: AppColors.textBody900),
              ),
            ),
            const SizedBox(width: AppSizes.s16),
            Expanded(
              child: Text(title, style: AppTypography.bodyLead),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.surface800,
            ),
          ],
        ),
      ),
    );
  }
}
