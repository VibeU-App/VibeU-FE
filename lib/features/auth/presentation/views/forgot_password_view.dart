import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:vibeu_fe/utils/result.dart';

import 'package:vibeu_fe/config/themes/design_system.dart';
import 'package:vibeu_fe/config/ui/vibe_text_field.dart';
import 'package:vibeu_fe/config/ui/vibe_primary_button.dart';
import 'package:vibeu_fe/routing/routes.dart';

import '../controllers/forgot_password_controller.dart';

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
    widget.controller.getEmail.addListener(_onGetEmail);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ForgotPasswordView oldWidget) {
    oldWidget.controller.getEmail.removeListener(_onGetEmail);
    widget.controller.getEmail.addListener(_onGetEmail);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _email.dispose();
    widget.controller.getEmail.removeListener(_onGetEmail);
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
              child: PrevViewButton(onPressed: () { context.go(Routes.login); })
            ),

            const SizedBox(height: AppSizes.s24),

            const Header(
              title: 'Forgot Password ?',
              subTitle: 'Fill in your email to receive OTP code',
            ),

            const SizedBox(height: AppSizes.s16),

            VibeTextField(
              controller: _email,
              prefixIcon: Icon(
                Icons.mail_outline,
                color: AppColors.textMuted500,
                size: 32.0,
              ),
              label: 'Email Address',
            ),

            const SizedBox(height: AppSizes.s24),

            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                EmailButton(
                  text: 'Primary Email',
                  onPressed: () { controller.getPrimaryEmail.execute(); },
                ),
                EmailButton(
                  text: 'Recovery Email',
                  onPressed: () { controller.getRecoveryEmail.execute(); },
                )
              ]
            ),

            const SizedBox(height: AppSizes.s16),

            ListenableBuilder(
              listenable: controller,
              builder: (_, _) {
                return VibePrimaryButton(
                  text: 'Send OTP Code',
                  onPressed: () async {
                    await controller.getEmail.execute(_email.value.text);
                  },
                  running: controller.getEmail.isRunning,
                );
              }
            )
          ]
        )
      )
    );
  }

  void _onGetEmail() {
    final result = widget.controller.getEmail.result;
    switch(result) {
      case Ok():
        widget.controller.email = result.value;
        widget.controller.getEmail.clear();
        widget.controller.page.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        break;
      case Error():
        widget.controller.getEmail.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text( result.exception.toString() ),
          )
        );
        break;
    }
  }
}
