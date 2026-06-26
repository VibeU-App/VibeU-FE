import 'package:flutter/material.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';
import 'package:vibeu_fe/features/auth/presentation/create_password_screen.dart';

import 'widgets/transition_animation.dart';
import 'widgets/header.dart';
import 'widgets/otp_input_section.dart';
import 'widgets/prev_screen_button.dart';
import 'widgets/vibe_text_span.dart';
import 'widgets/background_gradient.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [
            const Align(
              alignment: .centerLeft,
              child: PrevScreenButton(),
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

            const Image(
              image: AssetImage('assets/images/otp.webp'),
              height: 204.0
            ),

            const SizedBox(height: 21.0),

            Column(
              crossAxisAlignment: .center,
              children: [
                Text(
                  'The OTP code has been sent to',
                  style: AppTypography.bodyStd,
                ),

                Text(
                  'abc@gmail.com',
                  style: AppTypography.h3.copyWith(color: AppColors.accent500),
                ),
              ]
            ),

            const SizedBox(height: 22.0),

            const SizedBox(height: 40, child: OtpInputSection()),

            const SizedBox(height: 20.0),

            VibeTextSpan(
              defaultStyle: AppTypography.bodyStd,
              inlineActionStyle: TextStyle(color: AppColors.textPrimary500),
              textSpan: [
                (
                  text: 'Haven\'t received OTP code? ',
                  onTap: null,
                ),
                (
                  text: 'Resend',
                  onTap: () async {},
                ),
              ]
            ),

            const SizedBox(height: 20.0),

            VibePrimaryButton(
              text: 'Sign Up', // fr?
              onPressed: () async { Navigator.of(context).push(createRoute(const CreatePasswordScreen())); },
              icon: Icon(AntDesign.arrowright, color: AppColors.surface500),
              iconAlignment: .end,
            )
          ],
        )
      )
    );
  }
}
