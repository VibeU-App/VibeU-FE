import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';
import 'package:vibeu_fe/routing/routes.dart';

import '../controllers/auth_controller.dart';

import '../widgets/email_button.dart';
import '../widgets/prev_view_button.dart';
import '../widgets/background_gradient.dart';
import '../widgets/header.dart';

class ForgotPasswordView extends HookConsumerWidget {
  const ForgotPasswordView({ super.key, });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    ref.listen(
      authControllerProvider,
      (prev, next) {
        next.whenOrNull(
          data: (_) { context.go(Routes.verifyOtp); }
        );
      },
    );

    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [

            Align(
              alignment: .centerLeft,
              child: PrevViewButton(onPressed: () { context.go(Routes.login); })
            ),

            const SizedBox(height: AppSizes.s24),

            const Header(
              title: 'Forgot Password ?',
              subTitle: 'Fill in your email to receive OTP code',
            ),

            const SizedBox(height: AppSizes.s16),

            VibeTextField(
              controller: email,
              prefixIcon: Icon(
                Icons.mail_outline,
                color: AppColors.textMuted500,
                size: AppSizes.s32,
              ),
              label: 'Email Address',
            ),

            const SizedBox(height: AppSizes.s24),

            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                EmailButton(
                  text: 'Primary Email',
                  onPressed: () {
                    ref.read(authControllerProvider.notifier).getPrimaryEmail();
                  },
                ),
                EmailButton(
                  text: 'Recovery Email',
                  onPressed: () {
                    ref.read(authControllerProvider.notifier).getRecoveryEmail();
                  },
                )
              ]
            ),

            const SizedBox(height: AppSizes.s16),

            VibePrimaryButton(
              text: 'Send OTP Code',
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).sendToEmail(email.value.text);
              },
              running: ref.watch(authControllerProvider).isLoading,
            ),
          ]
        )
      )
    );
  }
}
