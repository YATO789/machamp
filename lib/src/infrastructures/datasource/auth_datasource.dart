import 'package:machamp/src/infrastructures/provider/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_datasource.g.dart';

@riverpod
AuthDataSource authDataSource(Ref ref) {
  return AuthDataSource(ref.watch(supabaseClientProvider));
}

class AuthDataSource {
  AuthDataSource(this._client);
  final SupabaseClient _client;

  Future<AuthResponse> signInAnonymously() {
    return _client.auth.signInAnonymously();
  }

  User? currentUser() {
    return _client.auth.currentUser;
  }

  Stream<AuthState> authStateChanges() {
    return _client.auth.onAuthStateChange;
  }

  Future<void> signOut() {
    return _client.auth.signOut();
  }
}
