import 'flow_controller.dart';

enum AuthFlowType { register, forgotPasswordView }

class AuthFlowController extends FlowController {
  AuthFlowController(this.flowType);

  final AuthFlowType flowType;
  final int _otpLength = 6;
  String otp = '';
  String email = '';
  NewPassword newPassword = NewPassword._('');

  int get otpLength => _otpLength;
  
  void onNewPassword(String password) {
    newPassword = NewPassword._(password);
    notifyListeners();
  }
}

class NewPassword {
  NewPassword._(this.password)
  : isNotEmpty = password.isNotEmpty,
    hasMinLength = password.length >= 8,
    hasNumber = RegExp(r'\d').hasMatch(password),
    hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  final String password;
  final bool isNotEmpty;
  final bool hasMinLength;
  final bool hasNumber;
  final bool hasSpecialChar;

  int strength() {
    int strength = 0;
    if (isNotEmpty) strength++;
    if (hasMinLength) strength++;
    if (hasNumber) strength++;
    if (hasSpecialChar) strength++;
    return strength;
  }
}
