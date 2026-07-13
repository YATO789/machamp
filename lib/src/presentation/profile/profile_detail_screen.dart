import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/localization/app_assets.dart';

class ProfileDetailScreen extends HookConsumerWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(AppAssets.of(context)!.profileDetailTitle)),
      body: const Center(child: Text('Coming soon')),
    );
  }
}
