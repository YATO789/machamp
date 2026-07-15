import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/env/env.dart';
import 'package:machamp/src/core/constants/app_theme.dart';
import 'package:machamp/src/localization/app_assets.dart';
import 'package:machamp/src/router/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: Env.supabaseUrlDev,
    publishableKey: Env.supabasePublishableDev,
  );
  await GoogleSignIn.instance.initialize(
    clientId: Env.iosClientIdDev,
    serverClientId: Env.webClientIdDev,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Machamp',
      theme: appTheme,
      localizationsDelegates: AppAssets.localizationsDelegates,
      supportedLocales: AppAssets.supportedLocales,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
