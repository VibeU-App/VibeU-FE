import 'package:flutter/material.dart';
import 'package:vibeu_fe/config/themes/design_system.dart';

import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';

import '../controllers/register_controller.dart';

import '../widgets/background_gradient.dart';
import '../widgets/header.dart';
import '../widgets/terms_and_policy_section.dart';
import '../widgets/vibe_text_span.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
    required this.controller,
  });

  final RegisterController controller;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [
            const Header(
              title: 'Register Now!',
              subTitle: 'Fill in your email to create a new account',
            ),

            const SizedBox(height: 17.0),

            VibeTextField(
              label: 'Email Address',
              controller: _email,
              prefixIcon: Icon(
                Icons.mail_outline,
                color: AppColors.textMuted500,
                size: 32
              ),
            ),

            const SizedBox(height: 14.0),

            TermsAndPolicySection(
              termsButton: () async { widget.controller.termsOfServices(); },
              policyButton: () async { widget.controller.privacyPolicy(); },
              onChanged: (value) { widget.controller.termsComplied = value; }
            ),

            const SizedBox(height: 16.0),

            ListenableBuilder(
              listenable: widget.controller,
              builder: (_, _) {
                return VibePrimaryButton(
                  text: 'Sign Up',
                  onPressed: () async {
                    widget.controller.signUp(_email.value.text);
                  },
                  running: widget.controller.isRunning,
                );
              }
            ),

            const SizedBox(height: 16.0),

            Align(
              alignment: Alignment.center,
              child: VibeTextSpan(
                defaultStyle: AppTypography.button,
                inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
              )
              ..text('Already have an account? ')
              ..link('Sign in', () async { Navigator.of(context).pop(); })
            )
          ]
        )
      )
    );
  }
}
