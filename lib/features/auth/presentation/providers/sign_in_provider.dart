import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_provider.g.dart';

@riverpod
class SignInState extends _$SignInState {
  @override
  Future<String> build() async { return ""; }

  Future<void> signIn((String, String) user) async {
    if (state.isLoading) return;

    final (email, password) = user;
    state = const AsyncLoading();

    // TODO: implement auth repo signin
    await Future.delayed(const Duration(seconds: 2));
    print('sign in {$email} : {$password}'); 
    state = AsyncValue.data("$email $password");
  }

  Future<void> googleSignIn() async {
    //TODO: implement google sign in
    if (state.isLoading) return;

    state = const AsyncLoading();

    await Future.delayed(const Duration(seconds: 2));
    print('google sign in'); 
    state = AsyncValue.data("google sign in");
  }
}
