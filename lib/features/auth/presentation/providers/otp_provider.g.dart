// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OtpState)
final otpStateProvider = OtpStateProvider._();

final class OtpStateProvider extends $AsyncNotifierProvider<OtpState, void> {
  OtpStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'otpStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$otpStateHash();

  @$internal
  @override
  OtpState create() => OtpState();
}

String _$otpStateHash() => r'58c5b0ac99ebfa7eed85e24de65013ffd7875073';

abstract class _$OtpState extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
