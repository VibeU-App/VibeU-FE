import 'package:flutter/material.dart';

import 'package:vibeu_fe/config/widgets/vibe_text_field.dart';
import 'package:vibeu_fe/config/widgets/vibe_primary_button.dart';

import 'widgets/background_gradient.dart';
import 'widgets/prev_screen_button.dart';
import 'widgets/header.dart';
import 'widgets/password_requirement_box.dart';
import 'widgets/password_strength_indicator.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BackgroundGradient.gradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Align(
            alignment: .topCenter,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 412),
                child: Column(
                  crossAxisAlignment: .center,
                  children: [
                    
                    Align(
                      alignment: .centerLeft,
                      child: PrevScreenButton(),
                    ),

                    SizedBox(height: 14.6),

                    Align(
                      alignment: .centerLeft,
                      child: Header(
                        title: 'Create New Password',
                        subTitle: 'Your new password must be different from previously used password'
                      ),
                    ),

                    SizedBox(height: 32.0),

                    VibeTextField(
                      label: 'New Password',
                      prefixIcon: ImageIcon(
                        AssetImage('assets/images/lock1.webp'),
                        size: 32.0,
                      ),
                      isPassword: true,
                    ),

                    SizedBox(height: 16.0),

                    PasswordStrengthIndicator(),

                    SizedBox(height: 16.0),

                    VibeTextField(
                      label: 'Confirm New Password',
                      prefixIcon: ImageIcon(
                        AssetImage('assets/images/lock1.webp'),
                        size: 32.0,
                      ),
                      isPassword: true,
                    ),

                    SizedBox(height: 16.0),

                    PasswordRequirementsBox(),

                    SizedBox(height: 28.0),

                    VibePrimaryButton(
                      text: 'Reset Password',
                      onPressed: () {},
                    )
                  ]
                )
              )
            )
          )
        )
      )
    );
  }
}
