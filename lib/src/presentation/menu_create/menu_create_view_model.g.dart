// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_create_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MenuCreateViewModel)
final menuCreateViewModelProvider = MenuCreateViewModelFamily._();

final class MenuCreateViewModelProvider
    extends $NotifierProvider<MenuCreateViewModel, MenuCreateState> {
  MenuCreateViewModelProvider._({
    required MenuCreateViewModelFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'menuCreateViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$menuCreateViewModelHash();

  @override
  String toString() {
    return r'menuCreateViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MenuCreateViewModel create() => MenuCreateViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MenuCreateState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenuCreateState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MenuCreateViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$menuCreateViewModelHash() =>
    r'c0c413e4e091a9edc307e5f00f052b7e46b2a5fc';

final class MenuCreateViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          MenuCreateViewModel,
          MenuCreateState,
          MenuCreateState,
          MenuCreateState,
          String?
        > {
  MenuCreateViewModelFamily._()
    : super(
        retry: null,
        name: r'menuCreateViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MenuCreateViewModelProvider call(String? menuId) =>
      MenuCreateViewModelProvider._(argument: menuId, from: this);

  @override
  String toString() => r'menuCreateViewModelProvider';
}

abstract class _$MenuCreateViewModel extends $Notifier<MenuCreateState> {
  late final _$args = ref.$arg as String?;
  String? get menuId => _$args;

  MenuCreateState build(String? menuId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MenuCreateState, MenuCreateState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MenuCreateState, MenuCreateState>,
              MenuCreateState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
