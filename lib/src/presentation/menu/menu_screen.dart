import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/domain/entity/menu.dart';
import 'package:machamp/src/localization/app_assets.dart';
import 'package:machamp/src/presentation/menu/menu_view_model.dart';

class MenuScreen extends HookConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menusAsync = ref.watch(menuViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppAssets.of(context)!.menuTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => context.push('/menu/create'),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(Colors.white, AppColors.purple, 0.35)!,
                      AppColors.purple,
                      Color.lerp(Colors.black, AppColors.purple, 0.65)!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.purple.withValues(alpha: 0.45),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.add, color: AppColors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
      body: menusAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(
          child: Text(
            AppAssets.of(context)!.menuLoadFailed,
            style: const TextStyle(color: AppColors.grey),
          ),
        ),
        data: (menus) => menus.isEmpty
            ? Center(
                child: Text(
                  AppAssets.of(context)!.noMenus,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.grey),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                itemCount: menus.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final menu = menus[index];
                  return _MenuCard(
                    menu: menu,
                    onTap: () => context.push('/menu/${menu.id}'),
                  );
                },
              ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.menu, required this.onTap});

  final Menu menu;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    menu.name.isEmpty
                        ? AppAssets.of(context)!.untitledMenu
                        : menu.name,
                    style: const TextStyle(
                      color: AppColors.monoWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  AppAssets.of(context)!.itemCount(menu.exercises.length),
                  style: const TextStyle(
                    color: AppColors.purple,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (menu.exercises.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: menu.exercises
                    .take(5)
                    .map((me) => _ExerciseTag(name: me.exercise.name))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ExerciseTag extends StatelessWidget {
  const _ExerciseTag({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.white10,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        name,
        style: const TextStyle(color: AppColors.grey, fontSize: 12),
      ),
    );
  }
}
