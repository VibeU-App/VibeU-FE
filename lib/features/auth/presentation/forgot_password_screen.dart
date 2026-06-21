import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/widgets/vibe_text_field.dart';
import 'package:vibeu_fe/config/widgets/vibe_primary_button.dart';
import 'package:vibeu_fe/config/widgets/style/surface_low_shadow_container.dart';

import 'widgets/email_button.dart';
import 'widgets/prev_screen_button.dart';
import 'widgets/background_gradient.dart';
import 'widgets/header.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BackgroundGradient.gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: .topCenter,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 412),
              child: Column(
                crossAxisAlignment: .center,
                children: [

                  Align(alignment: .centerLeft, child: PrevScreenButton()),

                  SizedBox(height: 22.0),

                  Align(alignment: .centerLeft, child: Header(
                    title: 'Forgot Password ?',
                    subTitle: 'Fill in your email to receive OTP code',
                  )),

                  SizedBox(height: 17.0),

                  VibeTextField(
                    prefixIcon: Icon(Icons.mail_outline, color: AppColors.textMuted500),
                    label: 'Email Address',
                  ),

                  SizedBox(height: 20.0),

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

                  SizedBox(height: 19.0),

                  VibePrimaryButton(
                    text: 'Send OTP Code',
                    onPressed: () { Navigator.pushNamed(context, '/verification'); }
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}
