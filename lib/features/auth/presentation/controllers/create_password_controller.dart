import 'package:flutter/material.dart';
import 'dart:async';

class CreatePasswordController extends ChangeNotifier {
  CreatePasswordController();

  bool _running = false;
  bool get isRunning => _running;

  bool isNotEmpty = false;
  bool hasMinLength = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  Future<void> createPassword((String, String) password) async {
    // TODO: implement createPassword
    final (renew, confirm) = password;

    if (renew != confirm) {
      print('no matching password');
      return;
    }

    _running = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    print('created password');

    _running = false;
    notifyListeners();
  }

  int newPasswordStrength() {
    int strength = 0;
    if (isNotEmpty) strength++;
    if (hasMinLength) strength++;
    if (hasNumber) strength++;
    if (hasSpecialChar) strength++;
    return strength;
  }

  void newPassword(String password) {
    isNotEmpty = password.isNotEmpty;
    hasMinLength = password.length >= 8;
    hasNumber = RegExp(r'\d').hasMatch(password);
    hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    notifyListeners();
  }
}
