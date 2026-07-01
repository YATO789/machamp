// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_creation_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExerciseCreationViewModel)
final exerciseCreationViewModelProvider = ExerciseCreationViewModelProvider._();

final class ExerciseCreationViewModelProvider
    extends
        $NotifierProvider<ExerciseCreationViewModel, ExerciseCreationState> {
  ExerciseCreationViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseCreationViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseCreationViewModelHash();

  @$internal
  @override
  ExerciseCreationViewModel create() => ExerciseCreationViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExerciseCreationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExerciseCreationState>(value),
    );
  }
}

String _$exerciseCreationViewModelHash() =>
    r'9a706af4f8de7d1f6210157a8b0ef1a0a457a653';

abstract class _$ExerciseCreationViewModel
    extends $Notifier<ExerciseCreationState> {
  ExerciseCreationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ExerciseCreationState, ExerciseCreationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExerciseCreationState, ExerciseCreationState>,
              ExerciseCreationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
