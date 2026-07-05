import 'package:flutter/material.dart';
import 'package:vibeu_fe/features/auth/presentation/views/login_view.dart';
import 'package:vibeu_fe/features/auth/presentation/controllers/login_controller.dart';
import 'package:vibeu_fe/features/auth/presentation/widgets/otp_image_container.dart';

void main() {
  // debugRepaintRainbowEnabled = true;

  runApp(MaterialApp(
    home: LoginView(controller: LoginController()),
  ));
}
