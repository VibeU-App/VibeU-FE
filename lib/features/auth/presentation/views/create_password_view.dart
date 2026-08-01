import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hicons/flutter_hicons.dart';

import 'package:vibeu_fe/routing/routes.dart';
import 'package:vibeu_fe/config/UI/design_system.dart';

import '../controllers/auth_controller.dart';
import '../controllers/auth_state.dart';

import '../widgets/vibe_primary_button.dart';
import '../widgets/vibe_text_field.dart';
import '../widgets/background_gradient.dart';
import '../widgets/prev_view_button.dart';
import '../widgets/header.dart';
import '../widgets/password_requirement_box.dart';
import '../widgets/password_strength_indicator.dart';

class CreatePasswordView extends StatefulHookConsumerWidget {
  const CreatePasswordView({ super.key, });

  @override
  ConsumerState<CreatePasswordView> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends ConsumerState<CreatePasswordView> {
  late final AuthOperation? operation;
  late final String subTitle;
  late final String buttonText;
  late final VoidCallback callback;

  @override
  void initState() {
    super.initState();
    operation = ref.read(authControllerProvider).value?.operation;
    if (operation == .register) {
      buttonText = 'Create Password';
      subTitle = 'Your new password must fit the required criteria';
    } else if (operation == .forgotPassword) {
      buttonText = 'Reset Password';
      subTitle = 'Your new password must be different from previously used password';
    } else {
      buttonText = subTitle = 'operation is null: $operation';
    }
  }

  @override 
  Widget build(BuildContext context) {
    final newPasswordField = useTextEditingController();
    final confirmPasswordField = useTextEditingController();
    var password = useState(_NewPassword(''));
    ref.listen(
      authControllerProvider,
      (prev, next) {
        next.whenOrNull(
          data: (_) {
            if (next.value?.operation == .register) {
              context.go(Routes.profiling);
            } else {
              context.go(Routes.login);
            }
          }
        );
      },
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

            Header(
              title: 'Create New Password',
              subTitle: subTitle,
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

            VibePrimaryButton(
              text: buttonText,
              onPressed: () async {
                final controller = ref.read(authControllerProvider.notifier);

                // should read from User and write new emails to User instead,
                // once something like that is implemented
                final email = ref.read(authControllerProvider).value?.sendToEmail;

                // should pass new + confirmed password to a validator class before continuing
                switch (operation) {
                  case .register:
                    controller.register("acb@email", newPasswordField.text);
                    break;
                  case .forgotPassword:
                    controller.createPassword("abc@email", newPasswordField.text);
                    break;
                  default: break;
                }
              },
              running: ref.watch(authControllerProvider).isLoading,
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
