import 'package:flutter/material.dart';

class ForgotPasswordController extends ChangeNotifier {
  ForgotPasswordController();

  Future<void> getPrimaryEmail() async {
    // TODO: Implement getPrimaryEmail
    print('primary email!');
  }
   
  Future<void> getRecoveryEmail() async {
    // TODO: Implement getRecoveryEmail
    print('recovery email!');
  }

  Future<void> getEmail(String email) async {
    // TODO: Impelment getEmail
    print('get email!');
  }
}
