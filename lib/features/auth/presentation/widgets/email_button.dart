import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';

import 'package:vibeu_fe/config/ui/surface_low_shadow_container.dart';

class EmailButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const EmailButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SurfaceLowShadowContainer(
      child: SizedBox(
        width: 159.0,
        height: 44.0,
        child: OutlinedButton(
          style: ButtonStyle(
            side: WidgetStateProperty<BorderSide>.fromMap({
              WidgetState.hovered | WidgetState.pressed | WidgetState.dragged
              : BorderSide(
                color: AppColors.textPrimary500,
                width: 2.0,
              ),
              WidgetState.any
              : BorderSide(style: BorderStyle.none)
            }),
            shape: .all(const RoundedRectangleBorder(
              borderRadius: .all(.circular(AppSizes.r8)),
            )),
            foregroundColor: WidgetStateProperty<Color>.fromMap({
              WidgetState.hovered | WidgetState.pressed | WidgetState.dragged
              : AppColors.textPrimary500,
              WidgetState.any
              : Colors.black,
            }),
            padding: .all(const .all(0)),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            maxLines: 1,
            style: AppTypography.button,
          ),
        )
      )
    );
  }
}
