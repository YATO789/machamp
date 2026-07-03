// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activityLog)
final activityLogProvider = ActivityLogFamily._();

final class ActivityLogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WorkoutHistoryEntry>>,
          List<WorkoutHistoryEntry>,
          FutureOr<List<WorkoutHistoryEntry>>
        >
    with
        $FutureModifier<List<WorkoutHistoryEntry>>,
        $FutureProvider<List<WorkoutHistoryEntry>> {
  ActivityLogProvider._({
    required ActivityLogFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'activityLogProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activityLogHash();

  @override
  String toString() {
    return r'activityLogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<WorkoutHistoryEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WorkoutHistoryEntry>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return activityLog(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityLogProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityLogHash() => r'c83fd3f319c022163f5614411fd2da595e6679e6';

final class ActivityLogFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<WorkoutHistoryEntry>>,
          DateTime
        > {
  ActivityLogFamily._()
    : super(
        retry: null,
        name: r'activityLogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ActivityLogProvider call(DateTime weekStart) =>
      ActivityLogProvider._(argument: weekStart, from: this);

  @override
  String toString() => r'activityLogProvider';
}
