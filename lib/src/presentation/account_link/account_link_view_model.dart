import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/src/infrastructures/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_link_view_model.freezed.dart';
part 'account_link_view_model.g.dart';

@freezed
abstract class AccountLinkState with _$AccountLinkState {
  const factory AccountLinkState({@Default(false) bool isLoading}) =
      _AccountLinkState;
}

@riverpod
class AccountLinkViewModel extends _$AccountLinkViewModel {
  @override
  AccountLinkState build() => const AccountLinkState();

  Future<void> linkGoogleIdentity() async {
    state = state.copyWith(isLoading: true);
    try {
      await ref.read(authRepositoryProvider).linkGoogleIdentity();
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
