// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_preview_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SharePreviewViewModel)
final sharePreviewViewModelProvider = SharePreviewViewModelProvider._();

final class SharePreviewViewModelProvider
    extends $NotifierProvider<SharePreviewViewModel, SharePreviewState> {
  SharePreviewViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharePreviewViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharePreviewViewModelHash();

  @$internal
  @override
  SharePreviewViewModel create() => SharePreviewViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharePreviewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharePreviewState>(value),
    );
  }
}

String _$sharePreviewViewModelHash() =>
    r'587369997420ff9416eddb1127a605e9b70d658f';

abstract class _$SharePreviewViewModel extends $Notifier<SharePreviewState> {
  SharePreviewState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SharePreviewState, SharePreviewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SharePreviewState, SharePreviewState>,
              SharePreviewState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
