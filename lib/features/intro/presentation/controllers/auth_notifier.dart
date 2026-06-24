import 'auth_state.dart';

class AuthNotifier {
  final AuthState _state = const AuthInitial();

  AuthState get state => _state;

  void login(String email, String password) {
    // TODO: implement login logic
  }

  void register(String email, String password) {
    // TODO: implement register logic
  }
}
