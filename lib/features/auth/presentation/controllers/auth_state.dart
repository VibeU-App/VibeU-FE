enum AuthStep {
  idle,
  signIn,
  signInPasswordless,
  register,
  verifyOtp,
  resendOtp,
  forgotPassword,
  createPassword,
}
enum AuthOperation {
  register,
  forgotPassword,
  loginPasswordless,
}
class AuthState {
  AuthStep step;
  AuthOperation? operation;
  String sendToEmail;

  AuthState({
    required this.step,
    this.operation,
    this.sendToEmail = '',
  });
}
