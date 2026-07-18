// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkoutViewModel)
final workoutViewModelProvider = WorkoutViewModelFamily._();

final class WorkoutViewModelProvider
    extends $NotifierProvider<WorkoutViewModel, WorkoutState> {
  WorkoutViewModelProvider._({
    required WorkoutViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'workoutViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$workoutViewModelHash();

  @override
  String toString() {
    return r'workoutViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  WorkoutViewModel create() => WorkoutViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkoutState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkoutState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$workoutViewModelHash() => r'07dc79eb82a725507d3fb85446bebee6816dcc68';

final class WorkoutViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          WorkoutViewModel,
          WorkoutState,
          WorkoutState,
          WorkoutState,
          String
        > {
  WorkoutViewModelFamily._()
    : super(
        retry: null,
        name: r'workoutViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WorkoutViewModelProvider call(String menuId) =>
      WorkoutViewModelProvider._(argument: menuId, from: this);

  @override
  String toString() => r'workoutViewModelProvider';
}

abstract class _$WorkoutViewModel extends $Notifier<WorkoutState> {
  late final _$args = ref.$arg as String;
  String get menuId => _$args;

  WorkoutState build(String menuId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<WorkoutState, WorkoutState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WorkoutState, WorkoutState>,
              WorkoutState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
