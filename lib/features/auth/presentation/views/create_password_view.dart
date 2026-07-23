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

import '../controllers/auth_flow_controller.dart';
import '../providers/register_provider.dart';

import '../widgets/background_gradient.dart';
import '../widgets/prev_view_button.dart';
import '../widgets/header.dart';
import '../widgets/password_requirement_box.dart';
import '../widgets/password_strength_indicator.dart';

class CreatePasswordView extends HookConsumerWidget {
  const CreatePasswordView({
    super.key,
    required this.controller,
  });

  final AuthFlowController controller;

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    final newPassword = useTextEditingController();
    final confirmPassword = useTextEditingController();
    final register = ref.read(registerStateProvider.notifier);
    ref.listenQuick(registerStateProvider,
    onData: (_) { context.go(Routes.login); },
    handleError: true,
    );
    
    return BackgroundGradient(
      child: Align(
        alignment: .topCenter,
        child: ListView(
          children: [
            
            Align(
              alignment: .centerLeft,
              child: PrevViewButton(
                onPressed: () {
                  controller.page.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut
                  );
                }
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
              controller: newPassword,
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
              builder: ( _, _) {
                return PasswordStrengthIndicator(
                  strengthLevel: controller.newPassword.strength(),
                );
              }
            ),

            const SizedBox(height: AppSizes.s16),

            VibeTextField(
              label: 'Confirm New Password',
              controller: confirmPassword,
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
              builder: (_,  _) {
                final newPassword = controller.newPassword;
                return PasswordRequirementsBox(
                  hasMinLength: newPassword.hasMinLength,
                  hasNumber: newPassword.hasNumber,
                  hasSpecialChar: newPassword.hasSpecialChar,
                );
              }
            ),

            const SizedBox(height: AppSizes.s24),

            Consumer(
              builder: (_, _, _) {
                return VibePrimaryButton(
                  text: 'Reset Password',
                  onPressed: () async {
                    register.createPassword((
                      newPassword.text,
                      confirmPassword.text,
                    ));
                  },
                  running: ref.watch(registerStateProvider).isLoading,
                );
              }
            ),
          ]
        )
      )
    );
  }
}
