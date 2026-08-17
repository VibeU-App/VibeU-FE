import 'package:go_router/go_router.dart';
import '../features/intro/presentation/views/splash_screen.dart';
import '../features/intro/presentation/views/onboarding_view.dart';
import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/presentation/views/register_view.dart';
import '../features/auth/presentation/views/create_password_view.dart';
import '../features/auth/presentation/views/verify_otp_view.dart';
import '../features/auth/presentation/views/forgot_password_view.dart';

// Import Me Views
import '../features/Me/presentation/views/me_view.dart';
import '../features/Me/presentation/views/settings_view.dart';
import '../features/Me/presentation/views/edit_profile_view.dart';
import '../features/Me/presentation/views/update_tags_view.dart';
import '../features/Me/presentation/views/update_avatar_view.dart';

import 'routes.dart';

GoRouter router() => GoRouter(
    initialLocation: Routes.me,
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
          builder: (_, _) => const LoginView(),
      ),
      GoRoute(
          path: Routes.register,
          builder: (_, _) => const RegisterView(),
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (_, _) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: Routes.verifyOtp,
        builder: (_, _) => const VerifyOtpView(),
      ),
      GoRoute(
        path: Routes.createPassword,
        builder: (_, _) => const CreatePasswordView(),
      ),
      
      // Me Feature Routes
      GoRoute(
        path: Routes.me,
        builder: (_, _) => const MeView(),
        routes: [
          GoRoute(
            path: Routes.settings,
            builder: (_, _) => const SettingsView(),
          ),
          GoRoute(
            path: Routes.editProfile,
            builder: (_, _) => const EditProfileView(),
            routes: [
               GoRoute(
                path: Routes.updateTags,
                builder: (_, _) => const UpdateTagsView(),
              ),
              GoRoute(
                path: Routes.updateAvatar,
                builder: (_, _) => const UpdateAvatarView(),
              ),
            ]
          ),
        ]
      ),
    ]
);
