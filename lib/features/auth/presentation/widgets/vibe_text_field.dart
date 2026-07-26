import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'surface_low_shadow_container.dart';

class VibeTextField extends StatefulWidget {
  final String label;
  final Widget prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  const VibeTextField({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.onChanged,
    this.keyboardType,
  });

  @override
  State<VibeTextField> createState() => _VibeTextFieldState();
}

class _VibeTextFieldState extends State<VibeTextField> {
  late bool _obscureText;

  @override initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return SurfaceLowShadowContainer(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        children: [
          _IconBox(icon: widget.prefixIcon),
          
          const SizedBox(width: AppSizes.s8),

          Expanded(
            child: TextField(
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              onChanged: widget.onChanged,
              style: AppTypography.button,
              obscureText: _obscureText,
              cursorColor: AppColors.textPrimary500,
              decoration: InputDecoration(
                border: InputBorder.none,
                label: Text(widget.label),
                labelStyle: AppTypography.caption.copyWith(
                  color: AppColors.textMuted200
                ),
              ),
            )
          ),

          if (widget.isPassword)...[
            IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off_outlined
                             : Icons.visibility_outlined,
                size: 20,
                color: AppColors.textMuted500,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
          ]
        ],
      ),
    );
  }
}


class _IconBox extends StatelessWidget {
  final Widget icon;

  const _IconBox({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 57.0,
      height: 66.0,
      child: Row(
        mainAxisAlignment: .end,
        mainAxisSize: .min,
        children: [
          const Spacer(),
          icon,
          const Spacer(),
          const VerticalDivider(
            width: 0, thickness: 0, color: AppColors.textMuted100,
          ),
        ]
      )
    );
  }
}
