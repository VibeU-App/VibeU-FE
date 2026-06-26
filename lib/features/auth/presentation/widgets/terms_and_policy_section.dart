import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/app_typography.dart';
import 'package:vibeu_fe/config/themes/app_colors.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/vibe_text_span.dart';

class TermsAndPolicySection extends StatefulWidget {
  final Future<void> Function() termsButton;
  final Future<void> Function() policyButton;

  const TermsAndPolicySection({
    super.key,
    required this.termsButton,
    required this.policyButton,
  });

  @override
  State<TermsAndPolicySection> createState() => _TermsAndPolicyState();
}

class _TermsAndPolicyState extends State<TermsAndPolicySection> {
  bool isChecked = false;

  @override
    Widget build(BuildContext context) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() { isChecked = !isChecked; });
              },
            ),

            VibeTextSpan(
              defaultStyle: AppTypography.overline,
              inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
              textSpan: [
                (
                  text: 'I agree with the ',
                  onTap: null,
                ),
                (
                  text: 'Terms of Service',
                  onTap: widget.termsButton,
                ),
                (
                  text: ' and ',
                  onTap: null,
                ),
                (
                  text: 'Privacy Policy',
                  onTap: widget.policyButton,
                ),
              ],
            ),
          ]
        )
      );
    }
}
