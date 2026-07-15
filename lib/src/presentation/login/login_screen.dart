import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/localization/app_assets.dart';
import 'package:machamp/src/presentation/login/login_view_model.dart';
import 'package:machamp/src/presentation/login/widgets/google_logo.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginViewModelProvider);
    final notifier = ref.read(loginViewModelProvider.notifier);
    final l10n = AppAssets.of(context)!;

    Future<void> signInAnonymously() async {
      try {
        await notifier.signInAnonymously();
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.loginFailed(e))));
        }
      }
    }

    Future<void> signInWithGoogle() async {
      try {
        await notifier.signInWithGoogle();
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.loginFailed(e))));
        }
      }
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A0030), AppColors.black],
          stops: [0.0, 0.65],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              'assets/images/app_icon.png',
                              width: 110,
                              height: 110,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Machamp',
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  color: AppColors.monoWhite,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: state.isLoading
                                ? null
                                : signInWithGoogle,
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
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: state.isLoading ? null : signInAnonymously,
                          child: Text(
                            l10n.signInAnonymously,
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (state.isLoading)
              Positioned.fill(
                child: ColoredBox(
                  color: const Color(0x80000000),
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.purple),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
