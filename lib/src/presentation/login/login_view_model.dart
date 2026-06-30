import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/src/infrastructures/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_view_model.freezed.dart';
part 'login_view_model.g.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({@Default(false) bool isLoading}) = _LoginState;
}

@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() => const LoginState();

  Future<void> signInAnonymously() async {
    state = state.copyWith(isLoading: true);
    try {
      await ref.read(authRepositoryProvider).signInAnonymously();
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
