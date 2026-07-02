import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/domain/entity/menu.dart';
import 'package:machamp/src/presentation/menu/menu_view_model.dart';

class MenuScreen extends HookConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menusAsync = ref.watch(menuViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('メニュー')),
      body: menusAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(
          child: Text(
            'データを取得できませんでした',
            style: TextStyle(color: AppColors.grey),
          ),
        ),
        data: (menus) => menus.isEmpty
            ? const Center(
                child: Text(
                  'メニューがありません\n新規作成から追加してください',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.grey),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/menu/create'),
        backgroundColor: AppColors.purple,
        foregroundColor: AppColors.white,
        icon: const Icon(Icons.add),
        label: const Text('新規作成'),
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
                    menu.name.isEmpty ? '無題のメニュー' : menu.name,
                    style: const TextStyle(
                      color: AppColors.monoWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${menu.exercises.length}項目',
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
