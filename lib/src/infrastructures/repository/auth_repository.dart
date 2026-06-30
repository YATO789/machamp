// ignore_for_file: avoid_types_on_closure_parameters

import 'package:machamp/src/domain/entity/app_user.dart';
import 'package:machamp/src/infrastructures/datasource/auth_datasource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(authDataSourceProvider));
}

@riverpod
Stream<AppUser?> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}

class AuthRepository {
  AuthRepository(this._dataSource);

  final AuthDataSource _dataSource;

  Future<AppUser> signInAnonymously() async {
    final response = await _dataSource.signInAnonymously();
    final user = response.user;
    if (user == null) throw Exception('signInAnonymously: user is null');
    return AppUser(id: user.id, isAnonymous: user.isAnonymous);
  }

  AppUser? currentUser() {
    final user = _dataSource.currentUser();
    if (user == null) return null;
    return AppUser(id: user.id, isAnonymous: user.isAnonymous);
  }

  Stream<AppUser?> authStateChanges() {
    return _dataSource.authStateChanges().map((AuthState state) {
      final user = state.session?.user;
      if (user == null) return null;
      return AppUser(id: user.id, isAnonymous: user.isAnonymous);
    });
  }

  Future<void> signOut() {
    return _dataSource.signOut();
  }
}
