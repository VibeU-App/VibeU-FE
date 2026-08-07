import 'package:go_router/go_router.dart';
import 'package:vibeu_fe/features/auth/presentation/controllers/auth_state.dart';

import '../features/auth/presentation/views/create_password_view.dart';
import '../features/auth/presentation/views/verify_otp_view.dart';
import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/presentation/views/register_view.dart';
import '../features/auth/presentation/views/forgot_password_view.dart';
import '../features/intro/presentation/views/splash_screen.dart';
import '../features/intro/presentation/views/onboarding_view.dart';
import '../features/profiling/presentation/views/profiling_view.dart';

import 'routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (_, _) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.onboarding,
      builder: (_, _) => const OnboardingView(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (_, _) => const LoginView()
    ),
    GoRoute(
      path: Routes.register,
      builder: (_, _) => const RegisterView(),
    ),
    GoRoute(
      path: Routes.forgotPassword,
      builder: (_, s) {
        final operation = s.extra! as AuthOperation;
        return ForgotPasswordView(operation: operation);
      }
    ),
    GoRoute(
      path: Routes.verifyOtp,
      builder: (_, s) {
        final operation = s.extra! as AuthOperation;
        return VerifyOtpView(operation: operation);
      }
    ),
    GoRoute(
      path: Routes.createPassword,
      builder: (_, s) {
        final operation = s.extra! as AuthOperation;
        return CreatePasswordView(operation: operation);
      }
    ),
    GoRoute(
      path: Routes.profiling,
      builder: (_, _) => const ProfilingView(),
    )
  ],
);
