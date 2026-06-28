import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/core/constants/app_color.dart';
import 'package:machamp/presentation/00_components/exercise_item.dart';
import 'package:machamp/presentation/00_components/primary_button.dart';
import 'package:machamp/presentation/menu_create/menu_create_view_model.dart';
import 'package:machamp/presentation/menu_create/widgets/exercise_selection_sheet.dart';

class MenuCreateScreen extends HookConsumerWidget {
  const MenuCreateScreen({super.key, this.menuId});

  final String? menuId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(menuCreateViewModelProvider(menuId));
    final notifier = ref.read(menuCreateViewModelProvider(menuId).notifier);

    final nameController = useTextEditingController(text: '');

    void openExerciseSheet() {
      unawaited(
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) =>
              ExerciseSelectionSheet(onAdd: notifier.addExercises),
        ),
      );
    }

    void save() {
      notifier.save(nameController.text.trim());
      if (context.mounted) context.pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(menuId != null ? 'メニュー編集' : 'メニュー作成'),
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
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: AppColors.monoWhite),
                    decoration: InputDecoration(
                      hintText: '例: 脚の日、上半身プッシュ',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: AppColors.darkSurface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
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
                      if (vm.menuExercises.isNotEmpty)
                        const Text(
                          '種目をタップして詳細を変更',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(vm.menuExercises.length, (index) {
                    final me = vm.menuExercises[index];
                    final isExpanded = vm.expandedIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ExerciseItem(
                        key: ValueKey(me.exercise.id + index.toString()),
                        menuExercise: me,
                        isExpanded: isExpanded,
                        isEditable: true,
                        exerciseIndex: index,
                        onTap: () {
                          notifier.setExpandedIndex(isExpanded ? null : index);
                        },
                        onDelete: () => notifier.removeExercise(index),
                        onSetCountChanged: (count) =>
                            notifier.updateSetCount(index, count),
                        onSetChanged: (setIdx, updated) =>
                            notifier.updateSet(index, setIdx, updated),
                      ),
                    );
                  }),
                  const SizedBox(height: 4),
                  _AddExerciseButton(onTap: openExerciseSheet),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: PrimaryButton(label: '保存する', onPressed: save),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddExerciseButton extends StatelessWidget {
  const _AddExerciseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: AppColors.monoWhite, size: 20),
            SizedBox(width: 6),
            Text(
              '種目を追加',
              style: TextStyle(
                color: AppColors.monoWhite,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
