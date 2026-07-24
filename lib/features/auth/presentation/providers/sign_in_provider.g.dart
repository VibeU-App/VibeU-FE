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
    extends $AsyncNotifierProvider<SignInState, String> {
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

String _$signInStateHash() => r'dd63e73f5eee83b2761eb43e25bbcd0d1daa8d3a';

abstract class _$SignInState extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
