// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MenuDetailViewModel)
final menuDetailViewModelProvider = MenuDetailViewModelFamily._();

final class MenuDetailViewModelProvider
    extends $NotifierProvider<MenuDetailViewModel, MenuDetailState> {
  MenuDetailViewModelProvider._({
    required MenuDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'menuDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$menuDetailViewModelHash();

  @override
  String toString() {
    return r'menuDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MenuDetailViewModel create() => MenuDetailViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MenuDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenuDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MenuDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$menuDetailViewModelHash() =>
    r'e7d450003638c93280dfd407297b785315feba9f';

final class MenuDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          MenuDetailViewModel,
          MenuDetailState,
          MenuDetailState,
          MenuDetailState,
          String
        > {
  MenuDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'menuDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MenuDetailViewModelProvider call(String menuId) =>
      MenuDetailViewModelProvider._(argument: menuId, from: this);

  @override
  String toString() => r'menuDetailViewModelProvider';
}

abstract class _$MenuDetailViewModel extends $Notifier<MenuDetailState> {
  late final _$args = ref.$arg as String;
  String get menuId => _$args;

  MenuDetailState build(String menuId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MenuDetailState, MenuDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MenuDetailState, MenuDetailState>,
              MenuDetailState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
