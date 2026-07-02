// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MenuViewModel)
final menuViewModelProvider = MenuViewModelProvider._();

final class MenuViewModelProvider
    extends $AsyncNotifierProvider<MenuViewModel, List<Menu>> {
  MenuViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menuViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menuViewModelHash();

  @$internal
  @override
  MenuViewModel create() => MenuViewModel();
}

String _$menuViewModelHash() => r'd6419193ff767d8d42e8d3a5a7aa316d1a138a69';

abstract class _$MenuViewModel extends $AsyncNotifier<List<Menu>> {
  FutureOr<List<Menu>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Menu>>, List<Menu>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Menu>>, List<Menu>>,
              AsyncValue<List<Menu>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
