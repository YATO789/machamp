import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/src/domain/entity/app_user.dart';
import 'package:machamp/src/infrastructures/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_view_model.freezed.dart';
part 'profile_view_model.g.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({AppUser? user}) = _ProfileState;
}

@riverpod
class ProfileViewModel extends _$ProfileViewModel {
  @override
  ProfileState build() {
    final authState = ref.watch(authStateChangesProvider);
    return ProfileState(user: authState.asData?.value);
  }

  Future<void> signOut() {
    return ref.read(authRepositoryProvider).signOut();
  }
}
