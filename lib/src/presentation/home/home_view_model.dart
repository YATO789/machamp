import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/src/domain/entity/app_user.dart';
import 'package:machamp/src/infrastructures/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.freezed.dart';
part 'home_view_model.g.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({AppUser? user}) = _HomeState;
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    final authState = ref.watch(authStateChangesProvider);
    return HomeState(user: authState.asData?.value);
  }

  Future<void> signOut() {
    return ref.read(authRepositoryProvider).signOut();
  }
}
