import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth_state.dart';

part 'auth_controller.g.dart';

// TODO: finish this
@riverpod
class AuthController extends _$AuthController {
  @override
  Future<AuthState> build() async {
    // TODO: inject repo
    return AuthState(step: .idle);
  }

  Future<void> signIn(String email,  String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return AuthState(step: .signIn);
    });
  }

  Future<void> signInWithEmail(String email) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return AuthState(step: .signIn);
    });
  }

  Future<void> googleSignIn() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return AuthState(step: .signIn);
    });
  }

  Future<void> register(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return AuthState(step: .createPassword, operation: .register);
    });
  }

  Future<void> createPassword(
    String newPassword,
    String confirmPassword
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return AuthState(step: .createPassword);
    });
  }

  Future<void> submitOtp({
    required AuthOperation operation,
    required String email,
    required String otp,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return AuthState(
        step: .verifyOtp,
        operation: operation,
        sendToEmail: email,
      );
    });
  }

  Future<void> resendOtp() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return AuthState(step: .idle);
    });
  }

  Future<void> sendToEmail({
    required AuthStep fromStep,
    required AuthOperation operation,
    required String email
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return AuthState(
        step: fromStep,
        operation: operation,
        sendToEmail: email
      );
    });
  }

  Future<String> getPrimaryEmail() async {
    // no state, retrieve directly from the repository
    return "primary@email";
  }

  Future<String> getRecoveryEmail() async {
    // no state, retrieve directly from the repository
    return "recovery@email";
  }

  Future<String> termsOfService() async {
    // no state, retrieve directly from the repository
    return "terms of service";
  }

  Future<String> privacyPolicy() async {
    // no state retrieve directly from the repository
    return "privacy policy";
  }
}
