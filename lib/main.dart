import 'package:flutter/material.dart';
import 'package:vibeu_fe/features/auth/presentation/login_screen.dart';
import 'package:vibeu_fe/features/auth/presentation/create_password_screen.dart';
import 'package:vibeu_fe/features/auth/presentation/forgot_password_screen.dart';
import 'package:vibeu_fe/features/auth/presentation/register_screen.dart';
import 'package:vibeu_fe/features/auth/presentation/verify_otp_screen.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
    routes: <String, WidgetBuilder> {
      '/login': (context) => const LoginScreen(),
      '/register': (context) => const RegisterScreen(),
      '/verification': (context) => const VerifyOtpScreen(),
      '/forgot_password': (context) => const ForgotPasswordScreen(),
      '/create_password': (context) => const CreatePasswordScreen(),
    },
  ));
}
