// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiling_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfilingController)
final profilingControllerProvider = ProfilingControllerProvider._();

final class ProfilingControllerProvider
    extends $NotifierProvider<ProfilingController, ProfilingState> {
  ProfilingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profilingControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profilingControllerHash();

  @$internal
  @override
  ProfilingController create() => ProfilingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfilingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfilingState>(value),
    );
  }
}

String _$profilingControllerHash() =>
    r'6074a975fd4eb685ca58b83c5407e2eeab1c7b32';

abstract class _$ProfilingController extends $Notifier<ProfilingState> {
  ProfilingState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ProfilingState, ProfilingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProfilingState, ProfilingState>,
              ProfilingState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(PersonalitySetup)
final personalitySetupProvider = PersonalitySetupProvider._();

final class PersonalitySetupProvider
    extends $NotifierProvider<PersonalitySetup, QuizAnswers> {
  PersonalitySetupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'personalitySetupProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$personalitySetupHash();

  @$internal
  @override
  PersonalitySetup create() => PersonalitySetup();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuizAnswers value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuizAnswers>(value),
    );
  }
}

String _$personalitySetupHash() => r'5b0538052be86508e1d9546c944f8c769fcec401';

abstract class _$PersonalitySetup extends $Notifier<QuizAnswers> {
  QuizAnswers build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<QuizAnswers, QuizAnswers>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<QuizAnswers, QuizAnswers>,
              QuizAnswers,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
