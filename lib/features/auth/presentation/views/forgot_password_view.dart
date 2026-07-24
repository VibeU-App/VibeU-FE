import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';
import 'package:vibeu_fe/routing/routes.dart';

import '../controllers/auth_flow_controller.dart';
import '../providers/email_providers.dart';
import 'package:vibeu_fe/utils/riverpod_extension.dart';

import '../widgets/email_button.dart';
import '../widgets/prev_view_button.dart';
import '../widgets/background_gradient.dart';
import '../widgets/header.dart';

class ForgotPasswordView extends HookConsumerWidget {
  const ForgotPasswordView({
    super.key,
    required this.controller,
  });

  final AuthFlowController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final emailState = ref.watch(emailStateProvider);
    final providers = ref.read(emailStateProvider.notifier);
    ref.listenQuick(
      emailStateProvider,
      onData: (data) {
        if (data.isEmpty) return;
        controller.email = data;
        controller.nextPage();
      },
      handleError: true,
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
                  onPressed: () { providers.getPrimaryEmail(); },
                ),
                EmailButton(
                  text: 'Recovery Email',
                  onPressed: () { providers.getRecoveryEmail(); },
                )
              ]
            ),

            const SizedBox(height: AppSizes.s16),

            Consumer(
              builder: (_, _, _) {
                return VibePrimaryButton(
                  text: 'Send OTP Code',
                  onPressed: () async {
                    await providers.getEmail(email.value.text);
                  },
                  running: emailState.isLoading,
                );
              }
            ),
          ]
        )
      )
    );
  }
}
