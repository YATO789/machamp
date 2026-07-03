// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_editor_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MenuEditorViewModel)
final menuEditorViewModelProvider = MenuEditorViewModelFamily._();

final class MenuEditorViewModelProvider
    extends $NotifierProvider<MenuEditorViewModel, MenuEditorState> {
  MenuEditorViewModelProvider._({
    required MenuEditorViewModelFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'menuEditorViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$menuEditorViewModelHash();

  @override
  String toString() {
    return r'menuEditorViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MenuEditorViewModel create() => MenuEditorViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MenuEditorState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenuEditorState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MenuEditorViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$menuEditorViewModelHash() =>
    r'941f53561655987bb06e447740edf4272a098ffb';

final class MenuEditorViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          MenuEditorViewModel,
          MenuEditorState,
          MenuEditorState,
          MenuEditorState,
          String?
        > {
  MenuEditorViewModelFamily._()
    : super(
        retry: null,
        name: r'menuEditorViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MenuEditorViewModelProvider call(String? menuId) =>
      MenuEditorViewModelProvider._(argument: menuId, from: this);

  @override
  String toString() => r'menuEditorViewModelProvider';
}

abstract class _$MenuEditorViewModel extends $Notifier<MenuEditorState> {
  late final _$args = ref.$arg as String?;
  String? get menuId => _$args;

  MenuEditorState build(String? menuId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MenuEditorState, MenuEditorState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MenuEditorState, MenuEditorState>,
              MenuEditorState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
