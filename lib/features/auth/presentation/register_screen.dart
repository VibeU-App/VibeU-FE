import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/themes/design_system.dart';

import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';

import 'widgets/background_gradient.dart';
import 'widgets/header.dart';
import 'widgets/terms_and_policy_section.dart';
import 'widgets/vibe_text_span.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Center(
        child: Column(
          children: [
            const Header(
              title: 'Register Now!',
              subTitle: 'Fill in your email to create a new account',
            ),

            const SizedBox(height: 17.0),

            const VibeTextField(
              label: 'Email Address',
              prefixIcon: Icon(
                Icons.mail_outline,
                color: AppColors.textMuted500,
                size: 32
              ),
            ),

            const SizedBox(height: 14.0),

            TermsAndPolicySection(
              termsButton: () async {},
              policyButton: () async {},
            ),

            const SizedBox(height: 16.0),

            VibePrimaryButton(
              text: 'Sign Up',
              onPressed: () async {}
            ),

            const SizedBox(height: 16.0),

            Align(
              alignment: Alignment.center,
              child: VibeTextSpan(
                defaultStyle: AppTypography.button,
                inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
                textSpan: [
                  (
                    text: 'Already have an account? ',
                    onTap: null,
                  ),
                  (
                    text: 'Sign in',
                    onTap: () async { Navigator.of(context).pop(); },
                  )
                ]
              ),
            )
          ]
        )
      )
    );
  }
}
