import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/localization/app_assets.dart';
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
          title: Text(
            AppAssets.of(ctx)!.deleteConfirmTitle(state.originalName),
          ),
          content: Text(AppAssets.of(ctx)!.irreversibleWarning),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(AppAssets.of(ctx)!.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(AppAssets.of(ctx)!.delete),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppAssets.of(context)!.deleteFailed)),
          );
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
        title: Text(
          menuId == null
              ? AppAssets.of(context)!.createMenuTitle
              : AppAssets.of(context)!.editMenuTitle,
        ),
        actions: [
          if (menuId != null)
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') unawaited(confirmAndDelete());
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'delete',
                  child: Text(AppAssets.of(context)!.delete),
                ),
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
                  Text(
                    AppAssets.of(context)!.menuNameLabel,
                    style: const TextStyle(
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
                      hintText: AppAssets.of(context)!.menuNameHint,
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
                      Text(
                        AppAssets.of(context)!.exercisesLabel,
                        style: const TextStyle(
                          color: AppColors.monoWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (state.menuExercises.isNotEmpty)
                        Text(
                          AppAssets.of(context)!.tapExerciseToEdit,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (state.menuExercises.isNotEmpty)
                    ReorderableListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      buildDefaultDragHandles: false,
                      onReorderItem: notifier.reorderExercises,
                      proxyDecorator: (child, index, animation) => Material(
                        elevation: 8,
                        color: Colors.transparent,
                        shadowColor: Colors.black54,
                        child: child,
                      ),
                      children: List.generate(state.menuExercises.length, (index) {
                        final me = state.menuExercises[index];
                        final isExpanded = state.expandedIndices.contains(index);
                        return Padding(
                          key: ValueKey(me.exercise.id + index.toString()),
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ExerciseItem(
                            menuExercise: me,
                            isExpanded: isExpanded,
                            isEditable: true,
                            exerciseIndex: index,
                            onTap: () => notifier.toggleExpandedIndex(index),
                            onDelete: () => notifier.removeExercise(index),
                            onSetCountChanged: (count) =>
                                notifier.updateSetCount(index, count),
                            onSetChanged: (setIdx, updated) =>
                                notifier.updateSet(index, setIdx, updated),
                            leading: ReorderableDragStartListener(
                              index: index,
                              child: const Icon(
                                Icons.drag_handle,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  const SizedBox(height: 4),
                  PrimaryButton(
                    label: AppAssets.of(context)!.addExercise,
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
                      label: AppAssets.of(context)!.startWorkout,
                      onPressed: () => context.push('/menu/$menuId/workout'),
                    )
                  : PrimaryButton(
                      label: AppAssets.of(context)!.save,
                      onPressed: state.isSaving ? null : save,
                      color: const Color(0xFF30D158),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
