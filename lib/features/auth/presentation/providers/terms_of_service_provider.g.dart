// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_of_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(termsOfService)
final termsOfServiceProvider = TermsOfServiceProvider._();

final class TermsOfServiceProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  TermsOfServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'termsOfServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$termsOfServiceHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return termsOfService(ref);
  }
}

String _$termsOfServiceHash() => r'4a3f9cc84f247febdbabd1bccee53459f3783087';
