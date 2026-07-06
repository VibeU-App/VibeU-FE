import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/presentation/controllers/login_controller.dart';
import '../features/auth/presentation/views/register_view.dart';
import '../features/auth/presentation/controllers/register_controller.dart';
import '../features/auth/presentation/views/forgot_password_view.dart';
import '../features/auth/presentation/views/verify_otp_view.dart';
import '../features/auth/presentation/views/create_password_view.dart';
import '../features/auth/presentation/controllers/forgot_password_controller.dart';

import 'routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.login,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (_, _) {
        return LoginView(
          controller: LoginController(),
        );
      }
    ),
    GoRoute(
      path: Routes.register,
      builder: (_, _) {
        return RegisterView(
          controller: RegisterController()
        );
      }
    ),
    GoRoute(
      path: Routes.forgotPassword,
      builder: (_, _) {
        final controller = ForgotPasswordController();
        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.page,
          children: [
            ForgotPasswordView(controller: controller),
            VerifyOtpView(controller: controller),
            CreatePasswordView(controller: controller),
          ]
        );
      }
    )
  ]
);
