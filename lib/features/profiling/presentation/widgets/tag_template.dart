import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

class TagTemplate extends StatelessWidget {
  const TagTemplate({
    super.key,
    required this.label,
    this.onRemoval,
    this.onToggle,
    this.removeable = false,
    this.toggle = false,
    this.enableToggle = true,
    this.toggleColor = AppColors.accent500,
    this.color = AppColors.surface600,
  });

  final String label;
  final ValueChanged<String>? onRemoval;
  final void Function(bool)? onToggle;
  final bool removeable;
  final bool toggle;
  final bool enableToggle;
  final Color toggleColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      key: ValueKey('tag_${label}_$toggle'),
      onPressed: () {
        if (enableToggle) {
          if (onToggle != null) {
            onToggle!(!toggle);
          }
        }
      },
      label: Text(
        label,
        style: AppTypography.caption.copyWith(
          color: toggle ? Colors.white : Colors.black
        )
      ),
      iconAlignment: .end,
      icon: removeable
        ? IconButton(
          onPressed: () {
            if (onRemoval != null) onRemoval!(label);
          },
          icon: const Icon(
            AntDesign.close,
            size: AppSizes.s16,
            color: Colors.black,
          ))
        : null,
      style: FilledButton.styleFrom(
        padding: const .symmetric(
          vertical: AppSizes.s8,
          horizontal: AppSizes.s16,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: .all(.circular(AppSizes.r999)),
          side: .none,
        ),
        backgroundColor: toggle ? toggleColor : color,
        splashFactory: NoSplash.splashFactory,
        overlayColor: Colors.transparent,
      )
    );
  }
}
