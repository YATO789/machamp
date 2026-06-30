import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/presentation/login/login_view_model.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginViewModelProvider);
    final notifier = ref.read(loginViewModelProvider.notifier);

    Future<void> signInAnonymously() async {
      try {
        await notifier.signInAnonymously();
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('ログインに失敗しました: $e')));
        }
      }
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: state.isLoading ? null : signInAnonymously,
          child: state.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('匿名でログイン'),
        ),
      ),
    );
  }
}
