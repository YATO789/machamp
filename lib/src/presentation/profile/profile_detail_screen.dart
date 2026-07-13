import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/localization/app_assets.dart';
import 'package:machamp/src/presentation/profile/profile_view_model.dart';

class ProfileDetailScreen extends HookConsumerWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppAssets.of(context)!;
    final user = ref.watch(profileViewModelProvider).user;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileDetailTitle)),
      body: user == null
          ? const SizedBox.shrink()
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('ID: ...${user.id.substring(user.id.length - 8)}'),
                    if (user.isAnonymous) ...[
                      const SizedBox(height: 8),
                      Chip(label: Text(l10n.anonymousUserChip)),
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}
