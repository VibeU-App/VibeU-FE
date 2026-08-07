import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:vibeu_fe/config/UI/design_system.dart';
import 'package:vibeu_fe/routing/routes.dart';

import '../controllers/auth_controller.dart';
import '../controllers/auth_state.dart';

import '../widgets/vibe_text_field.dart';
import '../widgets/vibe_primary_button.dart';
import '../widgets/vibe_outlined_button.dart';
import '../widgets/prev_view_button.dart';
import '../widgets/background_gradient.dart';
import '../widgets/header.dart';

class ForgotPasswordView extends StatefulHookConsumerWidget {
  const ForgotPasswordView({
    super.key,
    required this.operation,
  });

  final AuthOperation operation;

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPasswordView> {
  late final String title;
  late final VoidCallback callback;

  @override
  void initState() {
    super.initState();
    if (widget.operation == .forgotPassword) {
      title = "Forgot Password ?";
    }
    else {
      title = "Login Passwordless";
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = useTextEditingController();
    ref.listen(
      authControllerProvider,
      (prev, next) {
        next.whenOrNull(
          data: (_) {
            if (next.value?.step == .forgotPassword ||
                next.value?.step == .signInPasswordless) {
              context.push(
                Routes.verifyOtp,
                extra: widget.operation
              );
            }
          }
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
              child: PrevViewButton(onPressed: () { context.pop(); })
            ),

            const SizedBox(height: AppSizes.s24),

            Header(
              title: title,
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

            Offstage(
              offstage: widget.operation == .loginPasswordless,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  VibeOutlinedButton(
                    text: 'Primary Email',
                    textStyle: AppTypography.button,
                    onPressed: () {
                      ref.read(authControllerProvider.notifier).getPrimaryEmail();
                    },
                  ),
                  VibeOutlinedButton(
                    text: 'Recovery Email',
                    textStyle: AppTypography.button,
                    onPressed: () {
                      ref.read(authControllerProvider.notifier).getRecoveryEmail();
                    },
                  )
                ]
              ),
            ),

            const SizedBox(height: AppSizes.s16),

            VibePrimaryButton(
              text: 'Send OTP Code',
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).sendToEmail(
                  fromStep: .forgotPassword,
                  email: email.value.text
                );
              },
              running: ref.watch(authControllerProvider).isLoading,
            ),
          ]
        )
      )
    );
  }
}
