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

  // Full paths for navigation
  static const meSettings = '/me/settings';
  static const meEditProfile = '/me/edit-profile';
  static const meUpdateTags = '/me/edit-profile/update-tags';
  static const meUpdateAvatar = '/me/edit-profile/update-avatar';

  static const profiling = '/profiling';
  static const questionnaire = '/profiling/questionnaire';

  static const createPost = '/create-post';
  static const postComments = '/post-comments';
  static const newsfeed = '/newsfeed';
}
