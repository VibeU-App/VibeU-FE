import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';

import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';
import 'package:vibeu_fe/features/auth/presentation/forgot_password_screen.dart';
import 'package:vibeu_fe/features/auth/presentation/register_screen.dart';

import 'widgets/transition_animation.dart';
import 'widgets/vibe_text_span.dart';
import 'widgets/header.dart';
import 'widgets/background_gradient.dart';
import 'widgets/forgot_password_button.dart';
import 'widgets/social_login_section.dart';
import 'widgets/social_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

          const VibeTextField(
            label: 'Email Address',
            prefixIcon: Icon(
              Icons.mail_outline,
              color: AppColors.textMuted500,
              size: 32,
            ),
          ),

          const SizedBox(height: 12.0),

          const VibeTextField(
            label: 'Password',
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
                createRoute(const ForgotPasswordScreen())
              );
            }
          ),

          const SizedBox(height: 27.0),

          VibePrimaryButton(
            text: 'Sign In',
            onPressed: () async {}
          ),

          const SizedBox(height: 21.0),

          SocialLoginSection(socialLoginButtonList: [
            SocialLoginButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/google.webp',
                height: 24.47,
              ),
              label: 'Continue with Google',
            ),
          ]),

          const SizedBox(height: 16.0),

          VibeTextSpan(
            defaultStyle: AppTypography.button.copyWith(
              color: AppColors.textMuted500,
            ),
            inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
            textSpan: [
              (text: 'Don\'t have an account? ', onTap: null),
              (text: 'Sign Up', onTap: () async {
                Navigator.of(context).push(
                  createRoute(const RegisterScreen())
                );
              }),
            ]
          )
        ]
      ))
    );
  }
}
