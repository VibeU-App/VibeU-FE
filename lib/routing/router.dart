import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/intro/presentation/views/splash_screen.dart';
import '../features/intro/presentation/views/onboarding_view.dart';

import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/presentation/views/register_view.dart';
import '../features/auth/presentation/views/create_password_view.dart';
import '../features/auth/presentation/views/verify_otp_view.dart';
import '../features/auth/presentation/views/forgot_password_view.dart';

import '../features/profiling/presentation/views/profiling_view.dart';
import '../features/profiling/presentation/views/questionaire_view.dart';

import '../features/Me/presentation/views/settings_view.dart';
import '../features/Me/presentation/views/edit_profile_view.dart';
import '../features/Me/presentation/views/update_tags_view.dart';
import '../features/Me/presentation/views/update_avatar_view.dart';

import '../features/auth/presentation/controllers/auth_state.dart';

import '../features/posts/presentation/views/create_post_view.dart';
import '../features/posts/presentation/views/post_comments_view.dart';
import '../features/main/presentation/views/main_navigation_view.dart';
import '../features/Me/presentation/controllers/me_state.dart';

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
    ),
    GoRoute(
      path: Routes.me,
      builder: (_, _) => const MainNavigationView(initialIndex: 4),
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
    GoRoute(
      path: Routes.newsfeed,
      builder: (_, _) => const MainNavigationView(initialIndex: 1),
    ),
    GoRoute(
      path: Routes.createPost,
      builder: (_, _) => const CreatePostView(),
    ),
    GoRoute(
      path: Routes.postComments,
      redirect: (_, s) {
        if (s.extra is! UserPost) {
          return Routes.newsfeed;
        }
        return null;
      },
      builder: (_, s) {
        final post = s.extra as UserPost;
        return PostCommentsView(post: post);
      },
    ),
  ]
);
