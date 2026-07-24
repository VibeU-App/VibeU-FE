import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'otp_provider.g.dart';

@riverpod
class OtpState extends _$OtpState {
  @override
  FutureOr<void> build() {}

  Future<void> submit(String otp) async {
    if (state.isLoading || otp.length != 6) return;
    state = const AsyncLoading();
    // TODO: implement submit

    await Future.delayed(const Duration(seconds: 2));
    print('submit otp: $otp');
    state = AsyncValue.data(null);
  }

  Future<void> resend() async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    // TODO: implement resend
    print('resendOtp');
    state = AsyncValue.data(null);
  }
}
