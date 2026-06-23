import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/ui/design_system.dart';

import 'package:vibeu_fe/config/widgets/style/surface_low_shadow_container.dart';

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
            side: .resolveWith<BorderSide>(
              (states) => states.contains(WidgetState.hovered) ?
                BorderSide(
                  color: AppColors.textPrimary500,
                  width: 2.0,
                )
                :
                BorderSide(style: BorderStyle.none)
            ),
            shape: .all(RoundedRectangleBorder(
              borderRadius: .circular(AppSizes.r8),
            )),
            foregroundColor: .resolveWith<Color>(
              (states) => states.contains(WidgetState.hovered) ?
                AppColors.textPrimary500 : Colors.black
            ),
            padding: .all(EdgeInsets.all(0)),
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
