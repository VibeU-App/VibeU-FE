import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hicons/flutter_hicons.dart';

import 'package:vibeu_fe/routing/routes.dart';
import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';

import '../widgets/vibe_text_span.dart';
import '../widgets/header.dart';
import '../widgets/background_gradient.dart';
import '../widgets/forgot_password_button.dart';
import '../widgets/social_login_section.dart';
import '../widgets/social_login_button.dart';

import '../providers/sign_in_provider.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({ super.key, });
  
  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
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
    final service = ref.read(signInStateProvider.notifier);
    ref.listen(signInStateProvider, _onSignIn);
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
              context.push(Routes.forgotPassword);
            }
          ),

          const SizedBox(height: AppSizes.s24),

          Consumer(
            builder: (_, ref, _) {
              return VibePrimaryButton(
                text: 'Sign in',
                onPressed: () async {
                  await service.signIn((
                    _email.value.text,
                    _password.value.text
                  ));
                },
                running: ref.watch(signInStateProvider).isLoading,
              );
            }
          ),

          const SizedBox(height: AppSizes.s24),

          SocialLoginSection(socialLoginButtonList: [
            SocialLoginButton(
              onPressed: () async {
                await service.googleSignIn();
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
            context.push(Routes.register);
          }),
        ]
      ))
    );
  }

  void _onSignIn(
    AsyncValue<dynamic>? previous,
    AsyncValue<dynamic>? next
  ) {
    next?.whenOrNull(
      error: (exception, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(exception.toString()))
        );
      }
    );
  }
}
