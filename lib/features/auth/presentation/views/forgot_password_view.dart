import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';

import 'verify_otp_view.dart';
import '../controllers/otp_controller.dart';
import '../controllers/forgot_password_controller.dart';

import '../widgets/transition_animation.dart';
import '../widgets/email_button.dart';
import '../widgets/prev_view_button.dart';
import '../widgets/background_gradient.dart';
import '../widgets/header.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({
    super.key,
    required this.controller,
  });

  final ForgotPasswordController controller;

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [

            const Align(alignment: .centerLeft, child: PrevViewButton()),

            const SizedBox(height: 22.0),

            const Header(
              title: 'Forgot Password ?',
              subTitle: 'Fill in your email to receive OTP code',
            ),

            const SizedBox(height: 17.0),

            VibeTextField(
              controller: _email,
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
                  onPressed: () { widget.controller.getPrimaryEmail(); },
                ),
                EmailButton(
                  text: 'Recovery Email',
                  onPressed: () { widget.controller.getRecoveryEmail(); },
                )
              ]
            ),

            const SizedBox(height: 19.0),

            VibePrimaryButton(
              text: 'Send OTP Code',
              onPressed: () async {
                widget.controller.getEmail(
                  _email.value.text
                );

                Navigator.of(context).push(
                  createRoute(VerifyOtpView(
                    controller: OtpController(email: _email.value.text) // demo purpose only
                  ))
                );
              }
            )
          ]
        )
      )
    );
  }
}
