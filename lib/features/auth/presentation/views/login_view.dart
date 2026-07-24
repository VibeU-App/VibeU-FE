import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hicons/flutter_hicons.dart';

import 'package:vibeu_fe/routing/routes.dart';
import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';
import 'package:vibeu_fe/utils/riverpod_extension.dart';

import '../controllers/auth_controller.dart';

import '../widgets/vibe_text_span.dart';
import '../widgets/header.dart';
import '../widgets/background_gradient.dart';
import '../widgets/forgot_password_button.dart';
import '../widgets/social_login_section.dart';
import '../widgets/social_login_button.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({ super.key, });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final controller = ref.read(authControllerProvider.notifier);
    ref.listenQuick(
      authControllerProvider,
      onData: (_) {},
      handleError: true,
    );

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
            controller: email,
            prefixIcon: Icon(
              Icons.mail_outline,
              color: AppColors.textMuted500,
              size: AppSizes.s32,
            ),
          ),

          const SizedBox(height: AppSizes.s16),

          VibeTextField(
            label: 'Password',
            controller: password,
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

          Consumer(
            builder: (_, _, _) {
              return VibePrimaryButton(
                text: 'Sign in',
                onPressed: () async {
                  controller.signIn(
                    email.text,
                    password.text
                  );
                },
                running: ref.watch(authControllerProvider).isLoading,
              );
            }
          ),

          const SizedBox(height: AppSizes.s24),

          SocialLoginSection(socialLoginButtonList: [
            SocialLoginButton(
              onPressed: () async {
                await controller.googleSignIn();
              },
              icon: const Image(
                image: AssetImage(AppAssets.google),
                height: AppSizes.s24,
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
            context.push(Routes.register);
          }),
        ]
      ))
    );
  }
}
