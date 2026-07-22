import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/presentation/views/register_view.dart';
import '../features/auth/presentation/views/forgot_password_view.dart';
import '../features/auth/presentation/views/verify_otp_view.dart';
import '../features/auth/presentation/views/create_password_view.dart';
import '../features/auth/presentation/controllers/auth_flow_controller.dart';

import 'routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.login,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (_, _) {
        return const LoginView();
      }
    ),
    GoRoute(
      path: Routes.register,
      builder: (_, _) {
        final controller = AuthFlowController(.register);
        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.page,
          children: [
            RegisterView(controller: controller),
            VerifyOtpView(controller: controller),
            CreatePasswordView(controller: controller),
          ]
        );
      },
    ),
    GoRoute(
      path: Routes.forgotPassword,
      builder: (_, _) {
        final controller = AuthFlowController(.forgotPasswordView);
        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.page,
          children: [
            ForgotPasswordView(controller: controller),
            VerifyOtpView(controller: controller),
            CreatePasswordView(controller: controller),
          ],
        );
      },
    ),
  ],
);
