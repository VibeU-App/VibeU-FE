import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_provider.g.dart';

@riverpod
class RegisterState extends _$RegisterState {
  @override
  FutureOr<void> build() {
    // TODO: inject auth repo
  }

  Future<void> register(String email) async {
    state = const AsyncLoading();
    // TODO: implement signUp

    await Future.delayed(const Duration(seconds: 2));
    print('sign up: $email');
    state = AsyncValue.data(null);
  }

  Future<void> createPassword((String, String) password) async {
    // TODO: implement createPassword
    state = const AsyncLoading();
    final (renew, confirm) = password;

    await Future.delayed(const Duration(seconds: 2));
    print('created password');
    state = AsyncValue.data(null);
  }
}
