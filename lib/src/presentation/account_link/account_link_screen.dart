import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/localization/app_assets.dart';
import 'package:machamp/src/presentation/account_link/account_link_view_model.dart';
import 'package:machamp/src/presentation/login/widgets/google_logo.dart';

class AccountLinkScreen extends HookConsumerWidget {
  const AccountLinkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppAssets.of(context)!;
    final state = ref.watch(accountLinkViewModelProvider);
    final notifier = ref.read(accountLinkViewModelProvider.notifier);

    Future<void> linkGoogleIdentity() async {
      try {
        await notifier.linkGoogleIdentity();
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.accountLinkSuccess)));
          while (context.canPop()) {
            context.pop();
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.loginFailed(e))));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.accountLinkTitle)),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.accountLinkDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: state.isLoading ? null : linkGoogleIdentity,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1F1F1F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const GoogleLogo(size: 20),
                        const SizedBox(width: 10),
                        Text(
                          l10n.signInWithGoogle,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (state.isLoading)
            Positioned.fill(
              child: ColoredBox(
                color: const Color(0x80000000),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}
