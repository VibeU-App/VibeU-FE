import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';
import 'package:vibeu_fe/features/auth/presentation/verify_otp_screen.dart';

import 'widgets/transition_animation.dart';
import 'widgets/email_button.dart';
import 'widgets/prev_screen_button.dart';
import 'widgets/background_gradient.dart';
import 'widgets/header.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [

            const Align(alignment: .centerLeft, child: PrevScreenButton()),

            const SizedBox(height: 22.0),

            const Header(
              title: 'Forgot Password ?',
              subTitle: 'Fill in your email to receive OTP code',
            ),

            const SizedBox(height: 17.0),

            const VibeTextField(
              prefixIcon: Icon(
                Icons.mail_outline,
                color: AppColors.textMuted500,
                size: 32.0,
              ),
              label: 'Email Address',
            ),

            const SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                EmailButton(
                  text: 'Primary Email',
                  onPressed: () {},
                ),
                EmailButton(
                  text: 'Recovery Email',
                  onPressed: () {},
                )
              ]
            ),

            const SizedBox(height: 19.0),

            VibePrimaryButton(
              text: 'Send OTP Code',
              onPressed: () async {
                Navigator.of(context).push(
                  createRoute(const VerifyOtpScreen())
                );
              }
            )
          ]
        )
      )
    );
  }
}
