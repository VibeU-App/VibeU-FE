// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmailState)
final emailStateProvider = EmailStateProvider._();

final class EmailStateProvider
    extends $AsyncNotifierProvider<EmailState, String> {
  EmailStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailStateHash();

  @$internal
  @override
  EmailState create() => EmailState();
}

String _$emailStateHash() => r'b1a5133cf3e0e7aa087e9a49bc5ac44c4621234e';

abstract class _$EmailState extends $AsyncNotifier<String> {
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
