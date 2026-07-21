import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/infrastructures/repository/auth_repository.dart';
import 'package:machamp/src/localization/app_assets.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppAssets.of(context)!;
    final user = ref.watch(authStateChangesProvider).asData?.value;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: [
          if (user?.isAnonymous ?? false)
            ListTile(
              title: Text(l10n.settingsLoginTitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/profile/settings/account_link'),
            ),
        ],
      ),
    );
  }
}
