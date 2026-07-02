// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_session_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(workoutSessionDataSource)
final workoutSessionDataSourceProvider = WorkoutSessionDataSourceProvider._();

final class WorkoutSessionDataSourceProvider
    extends
        $FunctionalProvider<
          WorkoutSessionDataSource,
          WorkoutSessionDataSource,
          WorkoutSessionDataSource
        >
    with $Provider<WorkoutSessionDataSource> {
  WorkoutSessionDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutSessionDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutSessionDataSourceHash();

  @$internal
  @override
  $ProviderElement<WorkoutSessionDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WorkoutSessionDataSource create(Ref ref) {
    return workoutSessionDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkoutSessionDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkoutSessionDataSource>(value),
    );
  }
}

String _$workoutSessionDataSourceHash() =>
    r'4de587f595650d7b4db867aa1744567b7e135a47';
