import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/presentation/00_components/exercise_item.dart';
import 'package:machamp/src/presentation/00_components/primary_button.dart';
import 'package:machamp/src/presentation/menu_editor/exercise_selection/exercise_selection_sheet.dart';
import 'package:machamp/src/presentation/menu_editor/menu_detail_view_model.dart';

class MenuDetailScreen extends HookConsumerWidget {
  const MenuDetailScreen({super.key, required this.menuId});

  final String menuId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(menuDetailViewModelProvider(menuId));
    final notifier = ref.read(menuDetailViewModelProvider(menuId).notifier);

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

    void save() {
      notifier.save(nameController.text.trim());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('メニュー詳細')),
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
              child: isDirty
                  ? PrimaryButton(label: '保存する', onPressed: save)
                  : PrimaryButton(
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
