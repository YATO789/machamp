// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_link_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountLinkViewModel)
final accountLinkViewModelProvider = AccountLinkViewModelProvider._();

final class AccountLinkViewModelProvider
    extends $NotifierProvider<AccountLinkViewModel, AccountLinkState> {
  AccountLinkViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountLinkViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountLinkViewModelHash();

  @$internal
  @override
  AccountLinkViewModel create() => AccountLinkViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountLinkState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountLinkState>(value),
    );
  }
}

String _$accountLinkViewModelHash() =>
    r'cbebc29c50c4a1d6c7295963da610cbb0f9b7187';

abstract class _$AccountLinkViewModel extends $Notifier<AccountLinkState> {
  AccountLinkState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AccountLinkState, AccountLinkState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AccountLinkState, AccountLinkState>,
              AccountLinkState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
