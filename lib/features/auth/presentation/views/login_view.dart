import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';

import '../controllers/register_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/forgot_password_controller.dart';
import 'forgot_password_view.dart';
import 'register_view.dart';

import '../widgets/transition_animation.dart';
import '../widgets/vibe_text_span.dart';
import '../widgets/header.dart';
import '../widgets/background_gradient.dart';
import '../widgets/forgot_password_button.dart';
import '../widgets/social_login_section.dart';
import '../widgets/social_login_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
    required this.controller,
  });
  
  final LoginController controller;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Center(child: ListView(
        children: [
          const Header(
            title: 'Welcome Back!',
            subTitle: 'Log in your VibeU account to experience a wonderful app',
            showBrand: true,
            alignCenter: true,
          ),

          const SizedBox(height: 28.0),

          VibeTextField(
            label: 'Email Address',
            controller: _email,
            prefixIcon: Icon(
              Icons.mail_outline,
              color: AppColors.textMuted500,
              size: 32,
            ),
          ),

          const SizedBox(height: 12.0),

          VibeTextField(
            label: 'Password',
            controller: _password,
            prefixIcon: Icon(
              Hicons.lock1LightOutline,
              color: AppColors.textMuted500,
              size: 40,
            ),
            isPassword: true,
          ),

          const SizedBox(height: 12.0),

          ForgotPasswordButton(
            onPressed: () {
              Navigator.of(context).push(
                createRoute(
                  ForgotPasswordView(
                    controller: ForgotPasswordController(),
                  )
                )
              );
            }
          ),

          const SizedBox(height: 27.0),

          ListenableBuilder(
            listenable: widget.controller,
            builder: (_, _) {
              return VibePrimaryButton(
                text: 'Sign in',
                onPressed: () async {
                  await widget.controller.signIn((
                    _email.value.text,
                    _password.value.text,
                  ));
                },
                running: widget.controller.isRunning,
              );
            }
          ),

          const SizedBox(height: 21.0),

          SocialLoginSection(socialLoginButtonList: [
            SocialLoginButton(
              onPressed: () async {
                await widget.controller.googleSignIn();
              },
              icon: const Image(
                image: AssetImage(AppAssets.google),
                height: 24.47,
              ),
              label: 'Continue with Google',
            ),
          ]),

          const SizedBox(height: 16.0),

          VibeTextSpan(
            defaultStyle: AppTypography.button.copyWith(
              color: AppColors.textMuted500
            ),
            inlineActionStyle: TextStyle(
              color: AppColors.textPrimary500
            ),
          )
          ..text('Don\'t have an account? ')
          ..link('Sign Up', () async {
            Navigator.of(context).push(
              createRoute(RegisterView(controller: RegisterController()))
            );
          }),
        ]
      ))
    );
  }
}
