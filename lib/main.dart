import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/env/env.dart';
import 'package:machamp/src/core/constants/app_theme.dart';
import 'package:machamp/src/router/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: Env.supabaseUrlDev,
    publishableKey: Env.supabasePublishableDev,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Machamp',
      theme: appTheme,
      routerConfig: router,
    );
  }
}
