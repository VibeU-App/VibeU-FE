import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:vibeu_fe/routing/routes.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

import '../controllers/auth_controller.dart';
import '../controllers/auth_state.dart';

import '../widgets/vibe_primary_button.dart';
import '../widgets/otp_image_container.dart';
import '../widgets/header.dart';
import '../widgets/otp_input_section.dart';
import '../widgets/prev_view_button.dart';
import '../widgets/vibe_text_span.dart';
import '../widgets/background_gradient.dart';

class VerifyOtpView extends StatefulHookConsumerWidget {
  const VerifyOtpView({
    super.key,
    required this.operation,
  });

  final AuthOperation operation;

  @override
  ConsumerState<VerifyOtpView> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends ConsumerState<VerifyOtpView> {
  late final String buttonText;
  late final String? email;

  @override
  void initState() {
    super.initState();
    email = ref.read(authControllerProvider).value?.sendToEmail;
    switch(widget.operation) {
      case .register:
        buttonText = "Sign Up";
        break;
      case .loginPasswordless:
        buttonText = "Sign In";
        break;
      case .forgotPassword:
        buttonText = "Create New Password";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const otpLength = 6;
    final otpField = useTextEditingController();
    final otpNode = useFocusNode();

    final controller = ref.read(authControllerProvider.notifier);

    ref.listen(
      authControllerProvider,
      (prev, next) {
        next.whenOrNull(
          data: (_) { 
            if (next.value?.step == .verifyOtp) {
              context.push(
                Routes.createPassword,
                extra: widget.operation,
              );
              otpField.clear();
            }
          }
        );
      },
    );

    useEffect(() {
      void listener() async {
        if (otpField.text.length == otpLength) {
          await controller.submitOtp(
            email: email!,
            otp: otpField.text
          );
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

            Center(
              child: VibeTextSpan(
                defaultStyle: AppTypography.bodyStd,
                inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
              )
              ..text('Haven\'t received OTP code? ')
              ..link('Resend', () async { controller.resendOtp(); }),
            ),

            const SizedBox(height: AppSizes.s24),

            VibePrimaryButton(
              text: buttonText,
              onPressed: () async {
                switch (widget.operation) {
                  case .loginPasswordless:
                    // the sign in function for Login Passwordless flow will redirect
                    // users to where? By default, currently it is Routes.login
                    context.go(Routes.login);
                    break;
                  case .forgotPassword:
                  case .register:
                    await controller.submitOtp(
                      email: email!,
                      otp: otpField.text
                    );
                }
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
