// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_session_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(workoutSessionRepository)
final workoutSessionRepositoryProvider = WorkoutSessionRepositoryProvider._();

final class WorkoutSessionRepositoryProvider
    extends
        $FunctionalProvider<
          WorkoutSessionRepository,
          WorkoutSessionRepository,
          WorkoutSessionRepository
        >
    with $Provider<WorkoutSessionRepository> {
  WorkoutSessionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutSessionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutSessionRepositoryHash();

  @$internal
  @override
  $ProviderElement<WorkoutSessionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WorkoutSessionRepository create(Ref ref) {
    return workoutSessionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkoutSessionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkoutSessionRepository>(value),
    );
  }
}

String _$workoutSessionRepositoryHash() =>
    r'c46c3dcc7f8f560b8e4936d8e1aad0e678f83d48';
