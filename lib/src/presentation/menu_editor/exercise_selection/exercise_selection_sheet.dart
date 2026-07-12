import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/domain/entity/body_part.dart';
import 'package:machamp/src/domain/entity/equipment.dart';
import 'package:machamp/src/domain/entity/exercise.dart';
import 'package:machamp/src/localization/app_assets.dart';
import 'package:machamp/src/presentation/00_components/app_dropdown.dart';
import 'package:machamp/src/presentation/00_components/primary_button.dart';
import 'package:machamp/src/presentation/menu_editor/exercise_creation/exercise_creation_sheet.dart';
import 'package:machamp/src/presentation/menu_editor/exercise_selection/exercise_selection_view_model.dart';

class ExerciseSelectionSheet extends HookConsumerWidget {
  const ExerciseSelectionSheet({super.key, required this.onAdd});

  final void Function(List<Exercise>) onAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context).languageCode;
    final searchQuery = useState('');
    final selectedBodyPart = useState<BodyPart?>(null);
    final selectedEquipment = useState<Equipment?>(null);

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
              Text(
                AppAssets.of(context)!.addExercises,
                style: const TextStyle(
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
                    hintText: AppAssets.of(context)!.searchHint,
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
                      child: AppDropdown<BodyPart?>(
                        value: selectedBodyPart.value,
                        items: [null, ...state.bodyParts],
                        itemLabel: (bp) => bp == null
                            ? AppAssets.of(context)!.allBodyParts
                            : bp.localizedDisplayName(locale),
                        onChanged: (v) => selectedBodyPart.value = v,
                        fontSize: 13,
                        iconSize: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppDropdown<Equipment?>(
                        value: selectedEquipment.value,
                        items: [null, ...state.equipments],
                        itemLabel: (eq) => eq == null
                            ? AppAssets.of(context)!.allEquipments
                            : eq.localizedDisplayName(locale),
                        onChanged: (v) => selectedEquipment.value = v,
                        fontSize: 13,
                        iconSize: 18,
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
                error: (_, __) => Expanded(
                  child: Center(
                    child: Text(
                      AppAssets.of(context)!.fetchDataFailed,
                      style: const TextStyle(color: Colors.grey),
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
                    final bp = selectedBodyPart.value;
                    final matchesBodyPart =
                        bp == null || e.bodyParts.contains(bp.name);
                    final eq = selectedEquipment.value;
                    final matchesEquipment =
                        eq == null || e.equipment == eq.name;
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
                                      color: AppColors.purple.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: AppColors.purple,
                                      size: 20,
                                    ),
                                  ),
                                  title: Text(
                                    AppAssets.of(context)!.createCustomExercise,
                                    style: const TextStyle(
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
                                title: Text(
                                  exercise.name,
                                  style: const TextStyle(
                                    color: AppColors.monoWhite,
                                    fontSize: 15,
                                  ),
                                ),
                                subtitle: Text(
                                  exercise.bodyParts
                                      .map(
                                        (name) => _bodyPartLabel(name, locale),
                                      )
                                      .join(' / '),
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
                                  ? AppAssets.of(context)!.addButton
                                  : AppAssets.of(context)!.addButtonWithCount(
                                      state.selectedIds.length,
                                    ),
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

String _bodyPartLabel(String name, String locale) {
  if (locale == 'en') {
    return const {
          'legs': 'Legs',
          'chest': 'Chest',
          'back': 'Back',
          'shoulders': 'Shoulders',
          'arms': 'Arms',
          'abs': 'Abs',
        }[name] ??
        name;
  }
  return const {
        'legs': '脚',
        'chest': '胸',
        'back': '背中',
        'shoulders': '肩',
        'arms': '腕',
        'abs': '腹筋',
      }[name] ??
      name;
}
