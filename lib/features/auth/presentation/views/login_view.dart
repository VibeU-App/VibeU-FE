import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hicons/flutter_hicons.dart';

import '../../../../utils/result.dart';

import 'package:vibeu_fe/routing/routes.dart';
import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';

import '../controllers/login_controller.dart';

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
    widget.controller.signIn.addListener(_onSignIn);
  }

  @override
  void didUpdateWidget(covariant LoginView oldWidget) {
    oldWidget.controller.signIn.removeListener(_onSignIn);
    widget.controller.signIn.addListener(_onSignIn);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller.signIn.removeListener(_onSignIn);
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return BackgroundGradient(
      child: Center(child: ListView(
        children: [
          const Header(
            title: 'Welcome Back!',
            subTitle: 'Log in your VibeU account to experience a wonderful app',
            showBrand: true,
            alignCenter: true,
          ),

          const SizedBox(height: AppSizes.s24),

          VibeTextField(
            label: 'Email Address',
            controller: _email,
            prefixIcon: Icon(
              Icons.mail_outline,
              color: AppColors.textMuted500,
              size: AppSizes.s32,
            ),
          ),

          const SizedBox(height: AppSizes.s16),

          VibeTextField(
            label: 'Password',
            controller: _password,
            prefixIcon: Icon(
              Hicons.lock1LightOutline,
              color: AppColors.textMuted500,
              size: 40.0,
            ),
            isPassword: true,
          ),

          const SizedBox(height: AppSizes.s8),

          ForgotPasswordButton(
            onPressed: () {
              context.go(Routes.forgotPassword);
            }
          ),

          const SizedBox(height: AppSizes.s24),

          ListenableBuilder(
            listenable: controller.signIn,
            builder: (_, _) {
              return VibePrimaryButton(
                text: 'Sign in',
                onPressed: () async {
                  await controller.signIn.execute((
                    _email.value.text,
                    _password.value.text
                  ));
                },
                running: controller.signIn.isRunning,
              );
            }
          ),

          const SizedBox(height: AppSizes.s24),

          SocialLoginSection(socialLoginButtonList: [
            SocialLoginButton(
              onPressed: () async {
                await controller.googleSignIn.execute();
              },
              icon: const Image(
                image: AssetImage(AppAssets.google),
                height: 24.47,
              ),
              label: 'Continue with Google',
            ),
          ]),

          const SizedBox(height: AppSizes.s16),

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
            context.go(Routes.register);
          }),
        ]
      ))
    );
  }

  void _onSignIn() {
    final result = widget.controller.signIn.result;
    switch(result) {
      case Ok():
        widget.controller.signIn.clear();
        
        // theres no home page so do nothing
        // context.go(Routes.home);
        break;
      case Error():
        widget.controller.signIn.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text( result.exception.toString() ),
          )
        );
        break;
    }
  }
}
