import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/presentation/controllers/auth_state.dart';

import '../features/auth/presentation/views/create_password_view.dart';
import '../features/auth/presentation/views/verify_otp_view.dart';
import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/presentation/views/register_view.dart';
import '../features/auth/presentation/views/forgot_password_view.dart';
import '../features/intro/presentation/views/splash_screen.dart';
import '../features/intro/presentation/views/onboarding_view.dart';
import '../features/profiling/presentation/views/profiling_view.dart';
import '../features/profiling/presentation/views/questionaire_view.dart';

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
      redirect: (_, s) {
        if (s.extra is! AuthOperation) {
          return Routes.login;
        }
        return null;
      },
      builder: (_, s) {
        return ForgotPasswordView(
          operation: s.extra as AuthOperation
        );
      }
    ),
    GoRoute(
      path: Routes.verifyOtp,
      redirect: (_, s) {
        if (s.extra is! AuthOperation) {
          return Routes.login;
        }
        return null;
      },
      builder: (_, s) {
        return VerifyOtpView(
          operation: s.extra as AuthOperation
        );
      }
    ),
    GoRoute(
      path: Routes.createPassword,
      redirect: (_, s) {
        if (s.extra is! AuthOperation) {
          return Routes.login;
        }
        return null;
      },
      builder: (_, s) {
        return CreatePasswordView(
          operation: s.extra as AuthOperation
        );
      }
    ),
    GoRoute(
      path: Routes.profiling,
      builder: (_, _) => const ProviderScope(
        child: ProfilingView(),
      )
    ),
    GoRoute(
      path: Routes.questionnaire,
      builder: (_, _) => const QuestionaireView(),
    )
  ],
);
