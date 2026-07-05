import 'dart:async';

import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  LoginController();

  bool _running = false;
  bool get isRunning => _running;

  bool _googleRunning = false;
  bool get isGoogleRunning => _googleRunning;

  Future<void> signIn((String, String) user) async {
    if (_running) return;

    final (email, password) = user;
    _running = true;
    notifyListeners();

    // TODO: implement auth repo signin
    await Future.delayed(const Duration(seconds: 2));

    _running = false;
    notifyListeners();
    return;
  }


  Future<void> googleSignIn() async {
    //TODO: implement google sign in
    _googleRunning = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _googleRunning = false;
    notifyListeners();
    return;
  }
}
