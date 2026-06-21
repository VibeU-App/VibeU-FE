import 'package:flutter/material.dart';

import '../themes/design_system.dart';
import 'style/surface_low_shadow_container.dart';

class VibeTextField extends StatefulWidget {
  final String? label;
  final Widget? prefixIcon;
  final bool isPassword;

  // these configurations are specified in the Figma documentation
  // and not made up on a whim
  final double iconBoxWidth = 66.0;
  final double textFieldHeight = 57.0;

  const VibeTextField({
    super.key,
    this.label,
    this.prefixIcon,
    this.isPassword = false,
  });

  @override
    State<VibeTextField> createState() => _VibeTextFieldState();
}

class _VibeTextFieldState extends State<VibeTextField> {
  bool _obscureText = true;

  @override
    Widget build(BuildContext context) {
      return SurfaceLowShadowContainer(
        child: TextField(
          style: AppTypography.button,
          decoration: InputDecoration(
            border: InputBorder.none,
            label: widget.label != null ? Text(widget.label!) : null,
            labelStyle: AppTypography.caption.copyWith(
              color: AppColors.textMuted200
            ),
            prefixIcon: widget.prefixIcon != null ? 
              SizedBox(
                height: widget.textFieldHeight,
                width: widget.iconBoxWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Spacer(),
                    widget.prefixIcon!,
                    Spacer(),
                    VerticalDivider(
                      width: 0, thickness: 0, color: AppColors.textMuted100,
                    ),
                  ]
                )
              ) : null,
            suffixIcon: widget.isPassword
              ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                  color: AppColors.textMuted500,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ) : null,
          ),
        ),
      );
    }
}
