import 'package:go_router/go_router.dart';
import 'package:vibeu_fe/features/auth/presentation/views/create_password_view.dart';
import 'package:vibeu_fe/features/auth/presentation/views/verify_otp_view.dart';

import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/presentation/views/register_view.dart';
import '../features/auth/presentation/views/forgot_password_view.dart';

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
        return const RegisterView();
      },
    ),
    GoRoute(
      path: Routes.forgotPassword,
      builder: (_, _) {
        return const ForgotPasswordView();
      },
    ),
    GoRoute(
      path: Routes.verifyOtp,
      builder: (_, _) {
        return VerifyOtpView();
      },
    ),
    GoRoute(
      path: Routes.createPassword,
      builder: (_, _) {
        return const CreatePasswordView();
      },
    ),
  ],
);
