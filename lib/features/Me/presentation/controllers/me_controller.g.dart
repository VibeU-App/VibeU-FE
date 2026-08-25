// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MeController)
final meControllerProvider = MeControllerProvider._();

final class MeControllerProvider
    extends $NotifierProvider<MeController, MeState> {
  MeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'meControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$meControllerHash();

  @$internal
  @override
  MeController create() => MeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MeState>(value),
    );
  }
}

String _$meControllerHash() => r'e25066ec9618361e557e7400a8cb98bc9497c08e';

abstract class _$MeController extends $Notifier<MeState> {
  MeState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MeState, MeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MeState, MeState>,
              MeState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
