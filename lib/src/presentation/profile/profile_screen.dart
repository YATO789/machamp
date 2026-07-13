import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/localization/app_assets.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppAssets.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ListView(
        children: [
          ListTile(
            title: Text(l10n.profileDetailTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/profile/profile_detail'),
          ),
          ListTile(
            title: Text(l10n.settingsTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/profile/settings'),
          ),
          ListTile(
            title: Text(l10n.helpTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/profile/help'),
          ),
        ],
      ),
    );
  }
}
