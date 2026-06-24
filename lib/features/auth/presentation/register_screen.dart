import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/ui/design_system.dart';

import 'package:vibeu_fe/config/widgets/vibe_primary_button.dart';
import 'package:vibeu_fe/config/widgets/vibe_text_field.dart';

import 'widgets/background_gradient.dart';
import 'widgets/header.dart';
import 'widgets/terms_and_policy_section.dart';
import 'widgets/vibe_text_span.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: .topCenter,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 412),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Header(
                    title: 'Register Now!',
                    subTitle: 'Fill in your email to create a new account',
                  ),

                  SizedBox(height: 17.0),

                  VibeTextField(
                    label: 'Email Address',
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: AppColors.textMuted500,
                      size: 32
                    ),
                  ),

                  SizedBox(height: 14.0),

                  TermsAndPolicySection(
                    termsButton: () {},
                    policyButton: () {},
                  ),

                  SizedBox(height: 16.0),

                  VibePrimaryButton(
                    text: 'Sign Up',
                    onPressed: () {}
                  ),

                  SizedBox(height: 16.0),

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
                          onTap: () { Navigator.of(context).pop(); },
                        )
                      ]
                    ),
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}
