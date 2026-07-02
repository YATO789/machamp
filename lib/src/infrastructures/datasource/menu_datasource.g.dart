// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(menuDataSource)
final menuDataSourceProvider = MenuDataSourceProvider._();

final class MenuDataSourceProvider
    extends $FunctionalProvider<MenuDataSource, MenuDataSource, MenuDataSource>
    with $Provider<MenuDataSource> {
  MenuDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menuDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menuDataSourceHash();

  @$internal
  @override
  $ProviderElement<MenuDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MenuDataSource create(Ref ref) {
    return menuDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MenuDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenuDataSource>(value),
    );
  }
}

String _$menuDataSourceHash() => r'03a89b7821ef5a897fbfc32422c9498ce3fefb79';
