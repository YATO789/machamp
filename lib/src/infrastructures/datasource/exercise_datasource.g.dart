// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exerciseDataSource)
final exerciseDataSourceProvider = ExerciseDataSourceProvider._();

final class ExerciseDataSourceProvider
    extends
        $FunctionalProvider<
          ExerciseDataSource,
          ExerciseDataSource,
          ExerciseDataSource
        >
    with $Provider<ExerciseDataSource> {
  ExerciseDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exerciseDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exerciseDataSourceHash();

  @$internal
  @override
  $ProviderElement<ExerciseDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExerciseDataSource create(Ref ref) {
    return exerciseDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExerciseDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExerciseDataSource>(value),
    );
  }
}

String _$exerciseDataSourceHash() =>
    r'c632d0054a56fcc72079586fe305297246ec5ad3';
