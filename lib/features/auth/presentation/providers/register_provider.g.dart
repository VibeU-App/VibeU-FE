// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RegisterState)
final registerStateProvider = RegisterStateProvider._();

final class RegisterStateProvider
    extends $AsyncNotifierProvider<RegisterState, void> {
  RegisterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerStateHash();

  @$internal
  @override
  RegisterState create() => RegisterState();
}

String _$registerStateHash() => r'df8ff68ff9394461f9b83a00430aa683e000e8bf';

abstract class _$RegisterState extends $AsyncNotifier<void> {
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
