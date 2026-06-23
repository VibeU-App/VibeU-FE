import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/ui/design_system.dart';

import 'package:vibeu_fe/config/widgets/vibe_text_field.dart';
import 'package:vibeu_fe/config/widgets/vibe_primary_button.dart';

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
    return Container(
      decoration: BackgroundGradient.gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 412),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Header(
                  title: 'Welcome Back!',
                  subTitle: 'Log in your VibeU account to experience a wonderful app',
                  showBrand: true,
                  alignCenter: true,
                ),

                SizedBox(height: 28.0),

                VibeTextField(
                  label: 'Email Address',
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: AppColors.textMuted500,
                    size: 32,
                  ),
                ),

                SizedBox(height: 12.0),

                VibeTextField(
                  label: 'Password',
                  prefixIcon: ImageIcon(
                    AssetImage('assets/images/lock1.webp'),
                    color: AppColors.textMuted500,
                    size: 32,
                  ),
                  isPassword: true,
                ),

                SizedBox(height: 12.0),

                ForgotPasswordButton(
                  onPressed: () { Navigator.pushNamed(context, '/forgot_password'); },
                ),

                SizedBox(height: 27.0),

                VibePrimaryButton(
                  text: 'Sign In',
                  onPressed: () {}
                ),

                SizedBox(height: 21.0),

                SocialLoginSection(socialLoginButtonList: [
                  SocialLoginButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/google.webp'),
                    label: 'Continue with Google',
                  ),
                ]),

                SizedBox(height: 16.0),

                VibeTextSpan(
                  defaultStyle: AppTypography.button.copyWith(
                    color: AppColors.textMuted500,
                  ),
                  inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
                  textSpan: [
                    (text: 'Dont\'t have an account?', onTap: null),
                    (text: 'Sign Up', onTap: () {
                      Navigator.pushNamed(context, '/register');
                    }),
                  ]
                )
              ]
            )
          )
        )
      ))
    );
  }
}
