import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hicons/flutter_hicons.dart';

import 'package:vibeu_fe/routing/routes.dart';
import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';
import 'package:vibeu_fe/utils/riverpod_extension.dart';

import '../controllers/auth_controller.dart';

import '../widgets/background_gradient.dart';
import '../widgets/prev_view_button.dart';
import '../widgets/header.dart';
import '../widgets/password_requirement_box.dart';
import '../widgets/password_strength_indicator.dart';

class CreatePasswordView extends HookConsumerWidget {
  const CreatePasswordView({ super.key, });

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    final newPasswordField = useTextEditingController();
    final confirmPasswordField = useTextEditingController();
    var password = useState(_NewPassword(''));
    final controller = ref.read(authControllerProvider.notifier);
    ref.listenQuick(
      authControllerProvider,
      onData: (data) {
        if (data.goonerSpotted != null) {
          print('create password spotted a gooner too!');
          return;
        }
        context.go(Routes.login);
      },
      handleError: true
    );
    

    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [
            
            Align(
              alignment: .centerLeft,
              child: PrevViewButton(
                onPressed: () { context.pop(); }
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
              controller: newPasswordField,
              onChanged: (s) { password.value = _NewPassword(s); },
              prefixIcon: Icon(
                Hicons.lock1LightOutline,
                size: 40.0,
                color: AppColors.textMuted500,
              ),
              isPassword: true,
            ),

            const SizedBox(height: AppSizes.s16),

            ValueListenableBuilder(
              valueListenable: password,
              builder: ( _, p, _) {
                return PasswordStrengthIndicator(
                  strengthLevel: p.strength(),
                );
              }
            ),

            const SizedBox(height: AppSizes.s16),

            VibeTextField(
              label: 'Confirm New Password',
              controller: confirmPasswordField,
              prefixIcon: Icon(
                Hicons.lock1LightOutline,
                size: 40.0,
                color: AppColors.textMuted500,
              ),
              isPassword: true,
            ),

            const SizedBox(height: AppSizes.s16),

            ValueListenableBuilder(
              valueListenable: password,
              builder: (_, p, _) {
                return PasswordRequirementsBox(
                  hasMinLength: p.hasMinLength,
                  hasNumber: p.hasNumber,
                  hasSpecialChar: p.hasSpecialChar,
                );
              }
            ),

            const SizedBox(height: AppSizes.s24),

            Consumer(
              builder: (_, _, _) {
                return VibePrimaryButton(
                  text: 'Reset Password',
                  onPressed: () async {
                    controller.createPassword(
                      newPasswordField.text,
                      confirmPasswordField.text,
                    );
                  },
                  running: ref.watch(authControllerProvider).isLoading,
                );
              }
            ),
          ]
        )
      )
    );
  }
}

class _NewPassword {
  _NewPassword(this.password)
  : isNotEmpty = password.isNotEmpty,
    hasMinLength = password.length >= 8,
    hasNumber = RegExp(r'\d').hasMatch(password),
    hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  final String password;
  final bool isNotEmpty;
  final bool hasMinLength;
  final bool hasNumber;
  final bool hasSpecialChar;

  int strength() {
    int strength = 0;
    if (isNotEmpty) strength++;
    if (hasMinLength) strength++;
    if (hasNumber) strength++;
    if (hasSpecialChar) strength++;
    return strength;
  }
}
