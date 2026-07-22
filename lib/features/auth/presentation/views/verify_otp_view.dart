import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';

import '../controllers/auth_flow_controller.dart';
import '../providers/otp_provider.dart';

import '../widgets/otp_image_container.dart';
import '../widgets/header.dart';
import '../widgets/otp_input_section.dart';
import '../widgets/prev_view_button.dart';
import '../widgets/vibe_text_span.dart';
import '../widgets/background_gradient.dart';

class VerifyOtpView extends HookConsumerWidget {
  const VerifyOtpView({
    super.key,
    required this.controller,
  });

  final AuthFlowController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpField = useTextEditingController();
    final otpNode = useFocusNode();
    final otpState = ref.watch(otpStateProvider);
    final otp = ref.read(otpStateProvider.notifier);
    ref.listen(
      otpStateProvider,
      (prev, next) {
        next.whenOrNull(
          data: (_) { controller.nextPage(); },
          error: (error, _) {
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString()))
            );
          },
        );
      }
    );
    otpNode.addListener(() async {
      if (otpField.text.length == controller.otpLength) {
        await otp.submit(otpField.text);
      }
    });

    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [
            Align(
              alignment: .centerLeft,
              child: PrevViewButton(
                onPressed: () { controller.previousPage(); }
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
                  controller.email,
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
                otpLength: controller.otpLength,
              )
            ),

            const SizedBox(height: AppSizes.s24),

            VibeTextSpan(
              defaultStyle: AppTypography.bodyStd,
              inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
            )
            ..text('Haven\'t received OTP code? ')
            ..link('Resend', () async { otp.resend(); }),

            const SizedBox(height: AppSizes.s24),

            Consumer(
              builder: (_, _, _) {
                final text = controller.flowType == .register
                ? 'Sign Up'
                : 'Reset Password';

                return VibePrimaryButton(
                  text: text,
                  onPressed: () async {
                    await otp.submit(otpField.text);
                  },
                  icon: const Icon(
                    AntDesign.arrowright,
                    color: AppColors.surface500,
                    size: 28.0,
                  ),
                  running: otpState.isLoading,
                );
              },
            )
         ],
        )
      )
    );
  }
}
