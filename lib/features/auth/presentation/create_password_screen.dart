import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';

import 'package:vibeu_fe/config/themes/app_colors.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';

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
    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [
            
            const Align(
              alignment: .centerLeft,
              child: PrevScreenButton(),
            ),

            const SizedBox(height: 14.6),

            const Header(
              title: 'Create New Password',
              subTitle: 'Your new password must be different from previously used password'
            ),

            const SizedBox(height: 32.0),

            const VibeTextField(
              label: 'New Password',
              prefixIcon: Icon(
                Hicons.lock1LightOutline,
                size: 40.0,
                color: AppColors.textMuted500,
              ),
              isPassword: true,
            ),

            const SizedBox(height: 16.0),

            const PasswordStrengthIndicator(),

            const SizedBox(height: 16.0),

            const VibeTextField(
              label: 'Confirm New Password',
              prefixIcon: Icon(
                Hicons.lock1LightOutline,
                size: 40.0,
                color: AppColors.textMuted500,
              ),
              isPassword: true,
            ),

            const SizedBox(height: 16.0),

            const PasswordRequirementsBox(),

            const SizedBox(height: 28.0),

            VibePrimaryButton(
              text: 'Reset Password',
              onPressed: () async {},
            )
          ]
        )
      )
    );
  }
}
