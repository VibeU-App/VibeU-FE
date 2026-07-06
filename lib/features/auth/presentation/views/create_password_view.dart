import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hicons/flutter_hicons.dart';

import '../../../../utils/result.dart';
import '../../../../routing/routes.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';

import '../controllers/forgot_password_controller.dart';

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

  final ForgotPasswordController controller;

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
    widget.controller.createPassword.addListener(_createPassword);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CreatePasswordView oldWidget) {
    oldWidget.controller.removeListener(_createPassword);
    widget.controller.createPassword.addListener(_createPassword);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_createPassword);
    _newPassword.dispose();
    _confirmPassword.dispose();
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
              )
            ),

            const SizedBox(height: AppSizes.s16),

            const Header(
              title: 'Create New Password',
              subTitle: 'Your new password must be different from previously used password'
            ),

            const SizedBox(height: AppSizes.s32),

            VibeTextField(
              label: 'New Password',
              controller: _newPassword,
              onChanged: controller.onNewPassword,
              prefixIcon: Icon(
                Hicons.lock1LightOutline,
                size: 40.0,
                color: AppColors.textMuted500,
              ),
              isPassword: true,
            ),

            const SizedBox(height: AppSizes.s16),

            ListenableBuilder(
              listenable: controller,
              builder: (_, _) {
                return PasswordStrengthIndicator(
                    strengthLevel: controller.newPassword.strength(),
                );
              }
            ),

            const SizedBox(height: AppSizes.s16),

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

            const SizedBox(height: AppSizes.s16),

            ListenableBuilder(
              listenable: controller,
              builder: (_, _) {
                final newPassword = controller.newPassword;
                return PasswordRequirementsBox(
                  hasMinLength: newPassword.hasMinLength,
                  hasNumber: newPassword.hasNumber,
                  hasSpecialChar: newPassword.hasSpecialChar,
                );
              }
            ),

            const SizedBox(height: AppSizes.s24),

            ListenableBuilder(
              listenable: controller.createPassword,
              builder: (_, _) {
                return VibePrimaryButton(
                  text: 'Reset Password',
                  onPressed: () async {
                    controller.createPassword.execute((
                      _newPassword.value.text,
                      _confirmPassword.value.text,
                    ));
                  },
                  running: controller.createPassword.isRunning,
                );
              }
            )
          ]
        )
      )
    );
  }

  void _createPassword() {
    final result = widget.controller.createPassword.result;
    switch(result) {
      case Ok():
        widget.controller.createPassword.clear();
        
        // idk, maybe go back to login?
        context.go(Routes.login);
        break;
      case Error():
        widget.controller.createPassword.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text( result.exception.toString() ),
          )
        );
        break;
    }
  }
}
