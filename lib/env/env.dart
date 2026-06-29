import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
// ignore: avoid_classes_with_only_static_members
final class Env {
  @EnviedField(varName: 'SUPABASE_URL_DEV')
  static final String _supabaseUrlDev = _Env._supabaseUrlDev;

  // @EnviedField(varName: 'SUPABASE_URL')
  // static final String _supabaseUrlProd = _Env._supabaseUrlProd;

  /// 実行環境に応じてSupabase URLを返す
  // static String get supabaseUrl => switch (Flavor.current) {
  //   Flavor.dev => _supabaseUrlDev,
  //   Flavor.prod => _supabaseUrlProd,
  // };

  @EnviedField(varName: 'SUPABASE_PUBLISHABLE_KEY_DEV')
  static final String _supabaseAnonKeyDev = _Env._supabaseAnonKeyDev;

  // @EnviedField(varName: 'SUPABASE_ANON_KEY')
  // static final String _supabaseAnonKeyProd = _Env._supabaseAnonKeyProd;

  /// 実行環境に応じてSupabase Anon Keyを返す
  // static String get supabaseAnonKey => switch (Flavor.current) {
  //   Flavor.dev => _supabaseAnonKeyDev,
  //   Flavor.prod => _supabaseAnonKeyProd,
  // };
}
