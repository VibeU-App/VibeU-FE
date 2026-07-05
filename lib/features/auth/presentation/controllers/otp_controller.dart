import 'package:flutter/material.dart';
import 'dart:async';

class OtpController extends ChangeNotifier {
  // TODO: inject stuffs
  OtpController({ required String email, })
  : _email = email;

  final String _email;
  bool _running = false;
  String get email => _email;
  bool get isRunning => _running;

  Future<void> resend() async {
    // TODO: implement resend
    print('resend');
  }

  Future<bool> submit(String? otp) async {
    // TODO: implement submit
    if (otp == null || otp.isEmpty) {
      print('otp empty');
      return false;
    }
    
    if (otp.length != 6) {
      print('otp not complete');
      return false;
    }

    _running = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _running = false;
    notifyListeners();
    return true;
  }
}
