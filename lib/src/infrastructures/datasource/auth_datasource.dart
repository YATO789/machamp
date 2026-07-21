import 'package:google_sign_in/google_sign_in.dart';
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

  Future<AuthResponse> signInWithGoogle() async {
    final account = await GoogleSignIn.instance.authenticate();
    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw const GoogleSignInException(
        code: GoogleSignInExceptionCode.unknownError,
        description: 'signInWithGoogle: idToken is null',
      );
    }
    return _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
  }

  Future<AuthResponse> linkGoogleIdentity() async {
    final account = await GoogleSignIn.instance.authenticate();
    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw const GoogleSignInException(
        code: GoogleSignInExceptionCode.unknownError,
        description: 'linkGoogleIdentity: idToken is null',
      );
    }
    return _client.auth.linkIdentityWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
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
