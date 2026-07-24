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
  bool? goonerSpotted;

  AuthState({
    required this.step,
    this.sendToEmail = '',
  });

  @override
  String toString() {
    return step.toString();
  }
}
