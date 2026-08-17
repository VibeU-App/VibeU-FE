abstract final class Routes {
  static const splash = '/';
  static const onboarding = '/onboarding';

  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const createPassword = '/create-password';
  static const verifyOtp = '/verify-otp';

  static const me = '/me';
  static const settings = 'settings'; // sub-route
  static const editProfile = 'edit-profile'; // sub-route
  static const updateTags = 'update-tags'; // sub-route
  static const updateAvatar = 'update-avatar'; // sub-route

  static const profiling = '/profiling';
  static const questionnaire = '/profiling/questionnaire';
}
