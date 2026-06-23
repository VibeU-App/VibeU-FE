import 'package:flutter/material.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:vibeu_fe/config/ui/design_system.dart';
import 'package:vibeu_fe/config/widgets/vibe_primary_button.dart';

import 'widgets/header.dart';
import 'widgets/otp_input_section.dart';
import 'widgets/prev_screen_button.dart';
import 'widgets/vibe_text_span.dart';
import 'widgets/background_gradient.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BackgroundGradient.gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 412),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Align(
                      alignment: .centerLeft,
                      child: PrevScreenButton(),
                    ),

                    SizedBox(height: 20.8),

                    Align(
                      alignment: .centerLeft,
                      child: Header(
                        title: 'Verification',
                        subTitle: 'Verify the OTP sent to your entered email',
                      ),
                    ),

                    SizedBox(height: 37.0),

                    Image.asset('assets/images/otp.webp', height: 204.0),

                    SizedBox(height: 21.0),

                    Text(
                      'The OTP code has been sent to',
                      style: AppTypography.bodyStd,
                    ),

                    Text(
                      'abc@gmail.com',
                      style: AppTypography.h3.copyWith(color: AppColors.accent500),
                    ),

                    SizedBox(height: 22.0),

                    OtpInputSection(),

                    SizedBox(height: 20.0),

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
                          onTap: () {},
                        ),
                      ]
                    ),

                    SizedBox(height: 20.0),

                    VibePrimaryButton(
                      text: 'Sign Up', // fr?
                      onPressed: () { Navigator.pushNamed(context, '/create_password'); },
                      icon: Icon(AntDesign.arrowright, color: AppColors.surface500),
                      iconAlignment: .end,
                    )
                  ],
                )
              )
            )
          )
        )
      )
    );
  }
}
