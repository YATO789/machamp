import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/domain/constants/exercise_constants.dart';
import 'package:machamp/src/domain/entity/exercise.dart';
import 'package:machamp/src/presentation/00_components/primary_button.dart';
import 'package:machamp/src/presentation/menu_create/exercise_creation/exercise_creation_sheet.dart';
import 'package:machamp/src/presentation/menu_create/exercise_selection/exercise_selection_view_model.dart';

const _bodyParts = ['全ての部位', ...bodyParts];
const _equipment = ['全ての器具', ...equipments];

class ExerciseSelectionSheet extends HookConsumerWidget {
  const ExerciseSelectionSheet({super.key, required this.onAdd});

  final void Function(List<Exercise>) onAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = useState('');
    //TODO : view model側で状態を管理する
    final selectedBodyPart = useState(_bodyParts.first);
    final selectedEquipment = useState(_equipment.first);

    final state = ref.watch(exerciseSelectionViewModelProvider);
    final notifier = ref.read(exerciseSelectionViewModelProvider.notifier);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Material(
        color: AppColors.darkSurface,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.88,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '種目を追加',
                style: TextStyle(
                  color: AppColors.monoWhite,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  style: const TextStyle(color: AppColors.monoWhite),
                  decoration: InputDecoration(
                    hintText: '検索',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white10,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (v) => searchQuery.value = v,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _FilterDropdown(
                        value: selectedBodyPart.value,
                        items: _bodyParts,
                        onChanged: (v) => selectedBodyPart.value = v,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _FilterDropdown(
                        value: selectedEquipment.value,
                        items: _equipment,
                        onChanged: (v) => selectedEquipment.value = v,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              state.exercises.when(
                loading: () => const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.purple),
                  ),
                ),
                error: (_, __) => const Expanded(
                  child: Center(
                    child: Text(
                      'データの取得に失敗しました',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                data: (_) {
                  final combined = state.combinedExercises;
                  final filtered = combined.where((e) {
                    final matchesSearch =
                        searchQuery.value.isEmpty ||
                        e.name.toLowerCase().contains(
                          searchQuery.value.toLowerCase(),
                        );
                    final matchesBodyPart =
                        selectedBodyPart.value == _bodyParts.first ||
                        e.bodyPart == selectedBodyPart.value;
                    final matchesEquipment =
                        selectedEquipment.value == _equipment.first ||
                        e.equipment == selectedEquipment.value;
                    return matchesSearch && matchesBodyPart && matchesEquipment;
                  }).toList();

                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: filtered.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return ListTile(
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.purple.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: AppColors.purple,
                                      size: 20,
                                    ),
                                  ),
                                  title: const Text(
                                    'カスタム種目を作成',
                                    style: TextStyle(
                                      color: AppColors.purple,
                                      fontSize: 15,
                                    ),
                                  ),
                                  onTap: () {
                                    unawaited(
                                      showModalBottomSheet<Exercise?>(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (_) =>
                                            const ExerciseCreationSheet(),
                                      ).then((exercise) {
                                        if (exercise != null) {
                                          notifier.addCreatedExercise(exercise);
                                        }
                                      }),
                                    );
                                  },
                                );
                              }
                              final exercise = filtered[index - 1];
                              final isSelected = state.selectedIds.contains(
                                exercise.id,
                              );
                              return CheckboxListTile(
                                value: isSelected,
                                onChanged: (_) =>
                                    notifier.toggleExercise(exercise.id),
                                activeColor: AppColors.purple,
                                checkColor: Colors.white,
                                side: const BorderSide(color: Colors.grey),
                                secondary: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                title: Text(
                                  exercise.name,
                                  style: const TextStyle(
                                    color: AppColors.monoWhite,
                                    fontSize: 15,
                                  ),
                                ),
                                subtitle: Text(
                                  exercise.bodyPart,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                            child: PrimaryButton(
                              label: state.selectedIds.isEmpty
                                  ? '追加する'
                                  : '追加する (${state.selectedIds.length})',
                              onPressed: state.selectedIds.isEmpty
                                  ? null
                                  : () {
                                      onAdd(state.selectedExercises);
                                      Navigator.of(context).pop();
                                    },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: AppColors.darkSurface,
        style: const TextStyle(color: AppColors.monoWhite, fontSize: 13),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.grey,
          size: 18,
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }
}
