import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:vibeu_fe/routing/routes.dart';
import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';

import '../controllers/auth_flow_controller.dart';
import '../providers/register_provider.dart';
import '../providers/terms_of_service_provider.dart';
import '../providers/privacy_policy_provider.dart';

import '../widgets/background_gradient.dart';
import '../widgets/header.dart';
import '../widgets/terms_and_policy_section.dart';
import '../widgets/vibe_text_span.dart';

class RegisterView extends HookConsumerWidget {
  const RegisterView({
    super.key,
    required this.controller,
  });

  final AuthFlowController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final signUp = ref.read(registerStateProvider.notifier);
    final termsComplied = useState(false);
    ref.listen(
      registerStateProvider,
      (prev, next) {
        next.whenOrNull(
          data: (_) { controller.nextPage(); },
          error: (error, _) {
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString()))
            );
          }
        );
      }
    );
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
              controller: email,
              prefixIcon: Icon(
                Icons.mail_outline,
                color: AppColors.textMuted500,
                size: AppSizes.s32,
              ),
            ),

            const SizedBox(height: AppSizes.s16),

            TermsAndPolicySection(
              termsButton: () async { ref.watch(termsOfServiceProvider); },
              policyButton: () async { ref.watch(privacyPolicyProvider); },
              onChanged: (value) async { termsComplied.value = value; }
            ),

            const SizedBox(height: AppSizes.s16),

            Consumer(
              builder: (_, ref, _) {
                return VibePrimaryButton(
                  text: 'Sign Up',
                  onPressed: () async {
                    signUp.register(email.value.text);
                  },
                  running: ref.watch(registerStateProvider).isLoading,
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
}
