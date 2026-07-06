import 'package:flutter/material.dart';

import '../../../../utils/command.dart';
import '../../../../utils/result.dart';

class ForgotPasswordController extends ChangeNotifier {
  ForgotPasswordController() {
    getPrimaryEmail = Command0(_getPrimaryEmail);
    getRecoveryEmail = Command0(_getRecoveryEmail);
    getEmail = Command1<String, String>(_getEmail);
    resend = Command0(_resend);
    submitOtp = Command1<void, String?>(_submitOtp);
    createPassword = Command1<void, (String, String)>(_createPassword);
  }

  late Command0 getPrimaryEmail;
  late Command0 getRecoveryEmail;
  late Command1 getEmail;
  late Command0 resend;
  late Command1 submitOtp;
  late Command1 createPassword;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // dummy String email + otp field, TODO: replace it with something more robust
  late String email;

  // not a late field depends on can create_password_view go back to verify_otp_view
  // or to forgot_password_view
  String otp = ''; 

  NewPassword newPassword = NewPassword._('');
  final PageController _pageController = PageController();
  PageController get page => _pageController;

  void onNewPassword(String password) {
    newPassword = NewPassword._(password);
    notifyListeners();
  }

  Future<Result<void>> _getPrimaryEmail() async {
    // TODO: Implement getPrimaryEmail
    print('primary email!');
    return Result.ok(null);
  }
   
  Future<Result<void>> _getRecoveryEmail() async {
    // TODO: Implement getRecoveryEmail
    print('recovery email!');
    return Result.ok(null);
  }

  Future<Result<String>> _getEmail(String email) async {
    // TODO: Impelment getEmail
    if (email.isEmpty) {
      return Result.error(
        Exception('email field is empty')
      );
    }
    print('get email!');
    return Result.ok(email);
  }

  Future<Result<void>> _createPassword((String, String) password) async {
    // TODO: implement createPassword
    final (renew, confirm) = password;

    if (renew != confirm) {
      return Result.error(
        Exception('wrong confirm password')
      );
    }

    await Future.delayed(const Duration(seconds: 2));
    print('created password');
    return Result.ok(null);
  }

  Future<Result<void>> _resend() async {
    // TODO: implement resend
    print('resend');
    return Result.ok(null);
  }

  Future<Result<String>> _submitOtp(String? otp) async {
    // TODO: implement submit
    if (otp == null || otp.isEmpty) {
      return Result.error(
        Exception('otp empty')
      );
    }
    
    if (otp.length != 6) {
      return Result.error(
        Exception('otp not complete')
      );
    }

    print(submitOtp.isRunning);

    await Future.delayed(const Duration(seconds: 2));
    print('submit otp: $otp');
    return Result.ok(otp);
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
