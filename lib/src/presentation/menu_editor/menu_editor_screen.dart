import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/presentation/00_components/exercise_item.dart';
import 'package:machamp/src/presentation/00_components/primary_button.dart';
import 'package:machamp/src/presentation/menu_editor/exercise_selection/exercise_selection_sheet.dart';
import 'package:machamp/src/presentation/menu_editor/menu_editor_view_model.dart';

class MenuEditorScreen extends HookConsumerWidget {
  const MenuEditorScreen({super.key, this.menuId});

  final String? menuId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(menuEditorViewModelProvider(menuId));
    final notifier = ref.read(menuEditorViewModelProvider(menuId).notifier);

    final nameController = useTextEditingController(text: state.originalName);
    useListenable(nameController);

    final isDirty =
        nameController.text.trim() != state.originalName ||
        state.isExercisesDirty;

    void openExerciseSheet() {
      unawaited(
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => ExerciseSelectionSheet(onAdd: notifier.addExercises),
        ),
      );
    }

    Future<void> confirmAndDelete() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('「${state.originalName}」を削除しますか？'),
          content: const Text('この操作は取り消せません。'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('削除'),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
      try {
        await notifier.deleteMenu();
        if (context.mounted) context.pop();
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('削除に失敗しました')));
        }
      }
    }

    void save() {
      if (menuId == null) {
        unawaited(
          notifier.save(nameController.text.trim()).then((_) {
            if (context.mounted) context.pop();
          }),
        );
      } else {
        unawaited(notifier.save(nameController.text.trim()));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(menuId == null ? 'メニュー作成' : 'メニュー詳細'),
        actions: [
          if (menuId != null)
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') unawaited(confirmAndDelete());
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'delete', child: Text('削除')),
              ],
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
                      if (state.menuExercises.isNotEmpty)
                        const Text(
                          '種目をタップして詳細を変更',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(state.menuExercises.length, (index) {
                    final me = state.menuExercises[index];
                    final isExpanded = state.expandedIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ExerciseItem(
                        key: ValueKey(me.exercise.id + index.toString()),
                        menuExercise: me,
                        isExpanded: isExpanded,
                        isEditable: true,
                        exerciseIndex: index,
                        onTap: () => notifier.setExpandedIndex(
                          isExpanded ? null : index,
                        ),
                        onDelete: () => notifier.removeExercise(index),
                        onSetCountChanged: (count) =>
                            notifier.updateSetCount(index, count),
                        onSetChanged: (setIdx, updated) =>
                            notifier.updateSet(index, setIdx, updated),
                      ),
                    );
                  }),
                  const SizedBox(height: 4),
                  PrimaryButton(
                    label: '種目を追加',
                    onPressed: openExerciseSheet,
                    variant: PrimaryButtonVariant.ghost,
                    icon: Icons.add,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: menuId != null && !isDirty
                  ? PrimaryButton(
                      label: 'ワークアウト開始',
                      onPressed: () => context.push('/menu/$menuId/workout'),
                    )
                  : PrimaryButton(
                      label: '保存する',
                      onPressed: state.isSaving ? null : save,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
