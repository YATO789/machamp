import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/localization/app_assets.dart';
import 'package:machamp/src/presentation/home/home_view_model.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(homeViewModelProvider).user;
    final notifier = ref.read(homeViewModelProvider.notifier);

    if (user == null) return const SizedBox.shrink();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppAssets.of(context)!.homeTitle),
          const SizedBox(height: 8),
          Text('ID: ...${user.id.substring(user.id.length - 8)}'),
          if (user.isAnonymous) Chip(label: Text(AppAssets.of(context)!.anonymousUserChip)),
          ElevatedButton(
            onPressed: () async {
              await notifier.signOut();
            },
            child: Text(AppAssets.of(context)!.signOut),
          ),
        ],
      ),
    );
  }
}
