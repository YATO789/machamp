import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/application/providers/menus_provider.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/presentation/00_components/exercise_item.dart';
import 'package:machamp/src/presentation/00_components/primary_button.dart';

class MenuDetailScreen extends HookConsumerWidget {
  const MenuDetailScreen({super.key, required this.menuId});

  final String menuId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menus = ref.watch(menusProvider);
    final menu = menus.where((m) => m.id == menuId).firstOrNull;
    final expandedIndex = useState<int?>(null);

    if (menu == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('メニューが見つかりません')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('メニュー詳細'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push('/menu/$menuId/edit'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'メニュー名',
                    style: TextStyle(
                      color: AppColors.monoWhite,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      menu.name.isEmpty ? '無題のメニュー' : menu.name,
                      style: const TextStyle(
                        color: AppColors.monoWhite,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Text(
                        '種目',
                        style: TextStyle(
                          color: AppColors.monoWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (menu.exercises.isNotEmpty)
                        const Text(
                          '種目をタップして詳細を確認',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(menu.exercises.length, (index) {
                    final me = menu.exercises[index];
                    final isExpanded = expandedIndex.value == index;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ExerciseItem(
                        key: ValueKey(me.exercise.id + index.toString()),
                        menuExercise: me,
                        isExpanded: isExpanded,
                        isEditable: false,
                        onTap: () {
                          expandedIndex.value = isExpanded ? null : index;
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: PrimaryButton(
                label: 'ワークアウト開始',
                onPressed: () => context.push('/menu/$menuId/workout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
