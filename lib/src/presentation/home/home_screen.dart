import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
          const Text('ホーム'),
          const SizedBox(height: 8),
          Text('ID: ...${user.id.substring(user.id.length - 8)}'),
          if (user.isAnonymous) const Chip(label: Text('匿名ユーザー')),
          ElevatedButton(
            onPressed: () async {
              await notifier.signOut();
            },
            child: const Text('ログアウト'),
          ),
        ],
      ),
    );
  }
}
