import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';

import 'package:vibeu_fe/config/themes/app_colors.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';

import '../controllers/create_password_controller.dart';

import '../widgets/background_gradient.dart';
import '../widgets/prev_view_button.dart';
import '../widgets/header.dart';
import '../widgets/password_requirement_box.dart';
import '../widgets/password_strength_indicator.dart';

class CreatePasswordView extends StatefulWidget {
  const CreatePasswordView({
    super.key,
    required this.controller,
  });

  final CreatePasswordController controller;

  @override
  State<StatefulWidget> createState() => _CreatePasswordViewState();
}

class _CreatePasswordViewState extends State<CreatePasswordView> {
  late final TextEditingController _newPassword;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    _newPassword = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _newPassword.dispose();
    _confirmPassword.dispose();
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
              child: PrevViewButton()
            ),

            const SizedBox(height: 14.6),

            const Header(
              title: 'Create New Password',
              subTitle: 'Your new password must be different from previously used password'
            ),

            const SizedBox(height: 32.0),

            VibeTextField(
              label: 'New Password',
              controller: _newPassword,
              onChanged: widget.controller.newPassword,
              prefixIcon: Icon(
                Hicons.lock1LightOutline,
                size: 40.0,
                color: AppColors.textMuted500,
              ),
              isPassword: true,
            ),

            const SizedBox(height: 16.0),

            ListenableBuilder(
              listenable: widget.controller,
              builder: (_, _) {
                return PasswordStrengthIndicator(
                    strengthLevel: widget.controller.newPasswordStrength(),
                );
              }
            ),

            const SizedBox(height: 16.0),

            VibeTextField(
              label: 'Confirm New Password',
              controller: _confirmPassword,
              prefixIcon: Icon(
                Hicons.lock1LightOutline,
                size: 40.0,
                color: AppColors.textMuted500,
              ),
              isPassword: true,
            ),

            const SizedBox(height: 16.0),

            ListenableBuilder(
              listenable: widget.controller,
              builder: (_, _) {
                return PasswordRequirementsBox(
                  hasMinLength: widget.controller.hasMinLength,
                  hasNumber: widget.controller.hasNumber,
                  hasSpecialChar: widget.controller.hasSpecialChar,
                );
              }
            ),

            const SizedBox(height: 28.0),

            ListenableBuilder(
              listenable: widget.controller,
              builder: (_, _) {
                return VibePrimaryButton(
                  text: 'Reset Password',
                  onPressed: () async {
                    widget.controller.createPassword((
                      _newPassword.value.text,
                      _confirmPassword.value.text,
                    ));
                  },
                  running: widget.controller.isRunning,
                );
              }
            )
          ]
        )
      )
    );
  }
}
