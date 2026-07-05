import 'dart:async';

import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  // TODO: inject auth repo
  RegisterController();

  bool _running = false;
  bool get isRunning => _running;

  bool _termsComplied = false;
  set termsComplied(bool value) {
    _termsComplied = value;
  }

  Future<void> signUp(String email) async {
    // TODO: implement signUp
    if (!_termsComplied) {
      print('terms not complied');
      return;
    }

    if (email.isEmpty) {
      print('email empty');
      return;
    }

    _running = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _running = false;
    notifyListeners();
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
