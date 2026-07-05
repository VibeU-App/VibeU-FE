import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';

import 'create_password_view.dart';
import '../controllers/create_password_controller.dart';
import '../controllers/otp_controller.dart';

import '../widgets/otp_image_container.dart';
import '../widgets/transition_animation.dart';
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

  final OtpController controller;

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final _otp = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [
            const Align(
              alignment: .centerLeft,
              child: PrevViewButton(),
            ),

            const SizedBox(height: 20.8),

            const SizedBox(
              width: .infinity,
              child: Header(
                title: 'Verification',
                subTitle: 'Verify the OTP sent to your entered email',
              ),
            ),

            const SizedBox(height: 37.0),

            const OtpImageContainer(),

            const SizedBox(height: 21.0),

            Column(
              crossAxisAlignment: .center,
              children: [
                Text(
                  'The OTP code has been sent to',
                  style: AppTypography.bodyStd,
                ),

                Text(
                  widget.controller.email,
                  style: AppTypography.h3.copyWith(color: AppColors.accent500),
                ),
              ]
            ),

            const SizedBox(height: 22.0),

            SizedBox(
              height: 40,
              child: OtpInputSection(controller: _otp)
            ),

            const SizedBox(height: 20.0),

            VibeTextSpan(
              defaultStyle: AppTypography.bodyStd,
              inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
            )
            ..text('Haven\'t received OTP code? ')
            ..link('Resend', () async { widget.controller.resend(); }),

            const SizedBox(height: 20.0),

            ListenableBuilder(
              listenable: widget.controller,
              builder: (_, _) {
                return VibePrimaryButton(
                  text: 'Sign Up', // fr?
                  onPressed: () async {
                    if (await widget.controller.submit(_otp.value.text)) {
                      Navigator.of(context).push(
                        createRoute(
                          CreatePasswordView(
                            controller: CreatePasswordController(),
                          )
                        )
                      );
                    }
                  },
                  icon: const Icon(
                    AntDesign.arrowright,
                    color: AppColors.surface500,
                    size: 28.0,
                  ),
                  running: widget.controller.isRunning,
                );
              }
            )
         ],
        )
      )
    );
  }
}
