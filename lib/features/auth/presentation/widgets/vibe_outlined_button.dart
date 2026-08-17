import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';

class VibeOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle textStyle;
  final Icon? icon;
  final IconAlignment iconAlignment;
  final Color colorNormal;
  final Color colorActivated;
  final List<BoxShadow>? shadow;

  const VibeOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.textStyle,
    this.icon,
    this.iconAlignment = .start,
    this.colorNormal = Colors.black,
    this.colorActivated = AppColors.textPrimary500,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface500,
        boxShadow: shadow ?? [AppShadows.mid],
        borderRadius: const .all(.circular(AppSizes.s8)),
      ),
      child: SizedBox(
        width: 159.0,
        height: 44.0,
        child: OutlinedButton.icon(
          style: ButtonStyle(
            side: WidgetStateProperty<BorderSide>.fromMap({
              WidgetState.hovered | WidgetState.pressed | WidgetState.dragged
              : BorderSide(
                color: colorActivated,
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
              : colorActivated,
              WidgetState.any
              : colorNormal,
            }),
            padding: .all(const .all(0)),
          ),
          onPressed: onPressed,
          icon: icon,
          iconAlignment: iconAlignment,
          label: Text(
            text,
            maxLines: 1,
            style: textStyle,
          ),
        )
      )
    );
  }
}
