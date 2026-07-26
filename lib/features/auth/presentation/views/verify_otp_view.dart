import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:vibeu_fe/routing/routes.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

import '../controllers/auth_controller.dart';

import '../widgets/vibe_primary_button.dart';
import '../widgets/otp_image_container.dart';
import '../widgets/header.dart';
import '../widgets/otp_input_section.dart';
import '../widgets/prev_view_button.dart';
import '../widgets/vibe_text_span.dart';
import '../widgets/background_gradient.dart';

class VerifyOtpView extends HookConsumerWidget {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const otpLength = 6;

    final otpField = useTextEditingController();
    final otpNode = useFocusNode();

    final auth = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    final email = auth.value?.sendToEmail;
    final step = auth.value?.step;

    final buttonText = step == .register
      ? "Sign Up"
      : "Create New Password";

    ref.listen(
      authControllerProvider,
      (prev, next) {
        next.whenOrNull(
          data: (_) { context.go(Routes.createPassword); }
        );
      },
    );

    useEffect(() {
      void listener() async {
        if (otpField.text.length == otpLength) {
          await controller.submitOtp(otpField.text);
        }
      }
      otpField.addListener(listener);
      return () => otpField.removeListener(listener);
    }, [otpField, controller]);



    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [
            Align(
              alignment: .centerLeft,
              child: PrevViewButton(
                onPressed: () { context.pop(); }
              ),
            ),

            const SizedBox(height: AppSizes.s24),

            const SizedBox(
              width: .infinity,
              child: Header(
                title: 'Verification',
                subTitle: 'Verify the OTP sent to your entered email',
              ),
            ),

            const SizedBox(height: AppSizes.s32),

            const OtpImageContainer(),

            const SizedBox(height: AppSizes.s24),

            Column(
              crossAxisAlignment: .center,
              children: [
                Text(
                  'The OTP code has been sent to',
                  style: AppTypography.bodyStd,
                ),

                Text(
                  email!,
                  style: AppTypography.h3.copyWith(color: AppColors.accent500),
                ),
              ]
            ),

            const SizedBox(height: AppSizes.s24),

            SizedBox(
              height: 40,
              child: OtpInputSection(
                controller: otpField,
                node: otpNode,
                otpLength: otpLength,
              )
            ),

            const SizedBox(height: AppSizes.s24),

            VibeTextSpan(
              defaultStyle: AppTypography.bodyStd,
              inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
            )
            ..text('Haven\'t received OTP code? ')
            ..link('Resend', () async { controller.resendOtp(); }),

            const SizedBox(height: AppSizes.s24),

            VibePrimaryButton(
              text: buttonText,
              onPressed: () async {
                await controller.submitOtp(otpField.text);
              },
              icon: const Icon(
                AntDesign.arrowright,
                color: AppColors.surface500,
                size: 28.0,
              ),
              running: ref.watch(authControllerProvider).isLoading,
            ),
         ],
        )
      )
    );
  }
}
