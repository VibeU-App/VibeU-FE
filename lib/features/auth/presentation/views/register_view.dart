import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:vibeu_fe/utils/result.dart';

import 'package:vibeu_fe/routing/routes.dart';
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
    widget.controller.signUp.addListener(_onSignUp);
  }

  @override
  void didUpdateWidget(covariant RegisterView oldWidget) {
    oldWidget.controller.signUp.removeListener(_onSignUp);
    widget.controller.signUp.addListener(_onSignUp);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _email.dispose();
    widget.controller.signUp.removeListener(_onSignUp);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [
            const Header(
              title: 'Register Now!',
              subTitle: 'Fill in your email to create a new account',
            ),

            const SizedBox(height: AppSizes.s16),

            VibeTextField(
              label: 'Email Address',
              controller: _email,
              prefixIcon: Icon(
                Icons.mail_outline,
                color: AppColors.textMuted500,
                size: 32
              ),
            ),

            const SizedBox(height: AppSizes.s16),

            TermsAndPolicySection(
              termsButton: () async { controller.termsOfServices(); },
              policyButton: () async { controller.privacyPolicy(); },
              onChanged: (value) { controller.termsComplied = value; }
            ),

            const SizedBox(height: AppSizes.s16),

            ListenableBuilder(
              listenable: controller.signUp,
              builder: (_, _) {
                return VibePrimaryButton(
                  text: 'Sign Up',
                  onPressed: () async {
                    controller.signUp.execute(_email.value.text);
                  },
                  running: controller.signUp.isRunning,
                );
              }
            ),

            const SizedBox(height: AppSizes.s16),

            Align(
              alignment: Alignment.center,
              child: VibeTextSpan(
                defaultStyle: AppTypography.button,
                inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
              )
              ..text('Already have an account? ')
              ..link('Sign in', () async { context.pop(Routes.login); })
            )
          ]
        )
      )
    );
  }

  void _onSignUp() {
    final result = widget.controller.signUp.result;
    switch(result) {
      case Ok():
        widget.controller.signUp.clear();
        context.go(Routes.login);
        break;
      case Error():
        widget.controller.signUp.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text( result.exception.toString() ),
          )
        );
        break;
    }
  }
}
