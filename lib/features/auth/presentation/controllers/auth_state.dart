enum AuthStep {
  idle,
  signIn,
  register,
  verifyOtp,
  resendOtp,
  forgotPassword,
  createPassword,
}
class AuthState {
  AuthStep step;
  String sendToEmail;
  AuthState({
    required this.step,
    this.sendToEmail = '',
  });
}
