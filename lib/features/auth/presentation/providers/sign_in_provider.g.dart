// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SignInState)
final signInStateProvider = SignInStateProvider._();

final class SignInStateProvider
    extends $AsyncNotifierProvider<SignInState, void> {
  SignInStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInStateHash();

  @$internal
  @override
  SignInState create() => SignInState();
}

String _$signInStateHash() => r'a2a5335f34eca050522417b19f894ac5732d6761';

abstract class _$SignInState extends $AsyncNotifier<void> {
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
