// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_selection_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExerciseSelectionViewModel)
final exerciseSelectionViewModelProvider =
    ExerciseSelectionViewModelProvider._();

final class ExerciseSelectionViewModelProvider
    extends
        $NotifierProvider<ExerciseSelectionViewModel, ExerciseSelectionState> {
  ExerciseSelectionViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseSelectionViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseSelectionViewModelHash();

  @$internal
  @override
  ExerciseSelectionViewModel create() => ExerciseSelectionViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExerciseSelectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExerciseSelectionState>(value),
    );
  }
}

String _$exerciseSelectionViewModelHash() =>
    r'0ab9d76178653b1fa4c74d31edfe0cbe1543d44c';

abstract class _$ExerciseSelectionViewModel
    extends $Notifier<ExerciseSelectionState> {
  ExerciseSelectionState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<ExerciseSelectionState, ExerciseSelectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExerciseSelectionState, ExerciseSelectionState>,
              ExerciseSelectionState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
