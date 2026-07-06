import 'package:flutter/material.dart';

import '../../../../utils/command.dart';
import '../../../../utils/result.dart';

class RegisterController {
  // TODO: inject auth repo
  RegisterController() {
    signUp = Command1<void, String>(_signUp);
  }

  late Command1 signUp;

  bool _termsComplied = false;

  set termsComplied(bool value) { _termsComplied = value; }

  Future<Result<void>> _signUp(String email) async {
    // TODO: implement signUp
    if (!_termsComplied) {
      return Result.error(
        Exception('terms not complied!')
      );
    }

    if (email.isEmpty) {
      return Result.error(
        Exception('empty email field')
      );
    }

    await Future.delayed(const Duration(seconds: 2));
    print('sign up: $email');
    return Result.ok(null);
  }

  Future<void> termsOfServices() async {
    // TODO: implement termsOfServices
    // is this necessary?
  }

  Future<void> privacyPolicy() async {
    // TODO: implement privacyPolicy
    // is this necessary?
  }
}
