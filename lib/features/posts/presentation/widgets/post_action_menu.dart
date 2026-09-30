import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

class PostActionMenu extends StatelessWidget {
  final bool isPinned;
  final VoidCallback? onPin;
  final VoidCallback? onDelete;
  final Color iconColor;

  const PostActionMenu({
    super.key,
    this.isPinned = false,
    this.onPin,
    this.onDelete,
    this.iconColor = AppColors.textBody900,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: AppColors.primary500.withValues(alpha: 0.08),
      ),
      child: PopupMenuButton<String>(
        tooltip: 'Post options',
        icon: Icon(Icons.more_horiz, color: iconColor, size: 22),
        padding: EdgeInsets.zero,
        elevation: 6,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        color: AppColors.surface50,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.textBody900.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        offset: const Offset(-8, 36), // Positioned right under the 3-dots button
        onSelected: (value) {
          if (value == 'pin') {
            onPin?.call();
          } else if (value == 'delete') {
            onDelete?.call();
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem<String>(
            value: 'pin',
            height: 44,
            child: Row(
              children: [
                Icon(
                  isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                  color: AppColors.textBody900,
                  size: 20,
                ),
                const SizedBox(width: AppSizes.s12),
                Text(
                  isPinned ? 'Unpin this post' : 'Pin this post',
                  style: AppTypography.bodyStd.copyWith(
                    color: AppColors.textBody900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const PopupMenuDivider(height: 1),
          PopupMenuItem<String>(
            value: 'delete',
            height: 44,
            child: Row(
              children: [
                const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.primary500,
                  size: 20,
                ),
                const SizedBox(width: AppSizes.s12),
                Text(
                  'Delete this post',
                  style: AppTypography.bodyStd.copyWith(
                    color: AppColors.primary500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
