import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/UI/app_typography.dart';
import 'package:vibeu_fe/config/UI/app_colors.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/vibe_text_span.dart';

class TermsAndPolicySection extends StatefulWidget {
  final Future<void> Function() termsButton;
  final Future<void> Function() policyButton;
  final void Function(bool) onChanged;

  const TermsAndPolicySection({
    super.key,
    required this.termsButton,
    required this.policyButton,
    required this.onChanged,
  });

  @override
  State<TermsAndPolicySection> createState() => _TermsAndPolicyState();
}

class _TermsAndPolicyState extends State<TermsAndPolicySection> {
  bool isChecked = false;

  @override
    Widget build(BuildContext context) {
      return Align(
        alignment: .centerLeft,
        child: Row(
          mainAxisSize: .min,
          children: [
            Checkbox(
              activeColor: AppColors.textPrimary500,
              value: isChecked,
              onChanged: (bool? value) {
                setState(() { isChecked = !isChecked; });
                widget.onChanged(value!);
              },
            ),

            VibeTextSpan(
              defaultStyle: AppTypography.overline,
              inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
            )
            ..text('I agree with the ')
            ..link('Terms of Service', widget.termsButton)
            ..text(' and ')
            ..link('Privacy Policy', widget.policyButton),
          ]
        )
      );
    }
}
