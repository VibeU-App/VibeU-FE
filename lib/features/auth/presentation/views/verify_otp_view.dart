import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../../utils/result.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';
import 'package:vibeu_fe/features/auth/presentation/controllers/forgot_password_controller.dart';

import '../widgets/otp_image_container.dart';
import '../widgets/header.dart';
import '../widgets/otp_input_section.dart';
import '../widgets/prev_view_button.dart';
import '../widgets/vibe_text_span.dart';
import '../widgets/background_gradient.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({
    super.key,
    required this.controller,
  });

  final ForgotPasswordController controller;

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  late final TextEditingController _otp;

  @override
  void initState() {
    _otp = TextEditingController();

    // subjected to changes
    _otp.text = widget.controller.otp;

    widget.controller.submitOtp.addListener(_onSubmitOtp);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant VerifyOtpView oldWidget) {
    oldWidget.controller.submitOtp.removeListener(_onSubmitOtp);
    widget.controller.submitOtp.addListener(_onSubmitOtp);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _otp.dispose();
    widget.controller.submitOtp.removeListener(_onSubmitOtp);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [
            Align(
              alignment: .centerLeft,
              child: PrevViewButton(
                onPressed: () { controller.page.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                ); }
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
              child: OtpInputSection(controller: _otp)
            ),

            const SizedBox(height: AppSizes.s24),

            VibeTextSpan(
              defaultStyle: AppTypography.bodyStd,
              inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
            )
            ..text('Haven\'t received OTP code? ')
            ..link('Resend', () async { controller.resend.execute(); }),

            const SizedBox(height: AppSizes.s24),

            ListenableBuilder(
              listenable: controller.submitOtp,
              builder: (_, _) {
                return VibePrimaryButton(
                  text: 'Sign Up', // fr?
                  onPressed: () async {
                    await controller.submitOtp.execute(_otp.value.text);
                  },
                  icon: const Icon(
                    AntDesign.arrowright,
                    color: AppColors.surface500,
                    size: 28.0,
                  ),
                  running: controller.submitOtp.isRunning,
                );
              }
            )
         ],
        )
      )
    );
  }

  void _onSubmitOtp() {
    final result = widget.controller.submitOtp.result;
    switch(result) {
      case Ok():
        widget.controller.otp = result.value;
        widget.controller.submitOtp.clear();
        widget.controller.page.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        break;
      case Error():
        widget.controller.submitOtp.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text( result.exception.toString() ),
          )
        );
        break;
    }
  }
}
