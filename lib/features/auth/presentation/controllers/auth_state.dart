enum AuthStep {
  idle,
  signIn,
  signInPasswordless,
  register,
  verifyOtp,
  forgotPassword,
  createPassword,
}
class AuthState {
  final AuthStep step;
  final String sendToEmail;

  AuthState({
    required this.step,
    this.sendToEmail = '',
  });

  AuthState copyWith({
    AuthStep? step,
    String? sendToEmail,
  }) {
    return AuthState(
      step: step ?? this.step,
      sendToEmail: sendToEmail ?? this.sendToEmail,
    );
  }
}

enum AuthOperation {
  register,
  forgotPassword,
  loginPasswordless,
}
