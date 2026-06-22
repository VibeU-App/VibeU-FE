import 'auth_state.dart';
import 'package:flutter/foundation.dart'; // Để xài debugPrint

class AuthNotifier {
  AuthState _state = const AuthInitial();

  AuthState get state => _state;

  void login(String email, String password) {
    debugPrint('AuthNotifier: Login triggered for $email');
    // TODO: Partner will fully implement backend integration here.
    // Temporarily logging to satisfy state visibility and avoid silent no-ops.
  }

  void register(String email, String password) {
    debugPrint('AuthNotifier: Register triggered for $email');
    // TODO: Partner will fully implement backend integration here.
    // Temporarily logging to satisfy state visibility and avoid silent no-ops.
  }
}
