import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/domain/entity/body_part.dart';
import 'package:machamp/src/domain/entity/equipment.dart';
import 'package:machamp/src/localization/app_assets.dart';
import 'package:machamp/src/presentation/00_components/primary_button.dart';
import 'package:machamp/src/presentation/menu_editor/exercise_creation/exercise_creation_view_model.dart';

class ExerciseCreationSheet extends HookConsumerWidget {
  const ExerciseCreationSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context).languageCode;
    final nameController = useTextEditingController();
    final selectedBodyPartIds = useState<Set<String>>({});
    final selectedEquipment = useState<Equipment?>(null);

    final state = ref.watch(exerciseCreationViewModelProvider);
    final notifier = ref.read(exerciseCreationViewModelProvider.notifier);

    ref.listen<ExerciseCreationState>(exerciseCreationViewModelProvider, (
      _,
      next,
    ) {
      next.equipments.whenData((equipments) {
        if (selectedEquipment.value == null && equipments.isNotEmpty) {
          selectedEquipment.value = equipments.first;
        }
      });
    });

    Future<void> submit() async {
      final name = nameController.text.trim();
      if (name.isEmpty) return;
      final equipment = selectedEquipment.value;
      if (equipment == null) return;
      if (selectedBodyPartIds.value.isEmpty) return;

      final exercise = await notifier.createExercise(
        name: name,
        equipmentId: equipment.id,
        bodyPartIds: selectedBodyPartIds.value.toList(),
      );
      if (exercise != null && context.mounted) {
        Navigator.of(context).pop(exercise);
      } else if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(AppAssets.of(context)!.createExerciseFailed)));
      }
    }

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Material(
        color: AppColors.darkSurface,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  AppAssets.of(context)!.createCustomExercise,
                  style: const TextStyle(
                    color: AppColors.monoWhite,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppAssets.of(context)!.exerciseNameLabel,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: nameController,
                autofocus: true,
                style: const TextStyle(color: AppColors.monoWhite),
                decoration: InputDecoration(
                  hintText: AppAssets.of(context)!.exerciseNameHint,
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white10,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppAssets.of(context)!.bodyPartsLabel,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 8),
              state.bodyParts.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.purple,
                    strokeWidth: 2,
                  ),
                ),
                error: (_, __) => Text(
                  AppAssets.of(context)!.fetchDataFailed,
                  style: const TextStyle(color: Colors.grey),
                ),
                data: (bodyParts) => Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: bodyParts.map((bp) {
                    final isSelected = selectedBodyPartIds.value.contains(
                      bp.id,
                    );
                    return FilterChip(
                      label: Text(bp.localizedDisplayName(locale)),
                      selected: isSelected,
                      onSelected: (_) {
                        final next = Set<String>.from(
                          selectedBodyPartIds.value,
                        );
                        if (isSelected) {
                          next.remove(bp.id);
                        } else {
                          next.add(bp.id);
                        }
                        selectedBodyPartIds.value = next;
                      },
                      selectedColor: AppColors.purple.withValues(alpha: 0.3),
                      checkmarkColor: AppColors.purple,
                      backgroundColor: Colors.white10,
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.purple : Colors.grey,
                        fontSize: 13,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.purple
                            : Colors.transparent,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppAssets.of(context)!.equipmentLabel,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 6),
              state.equipments.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.purple,
                    strokeWidth: 2,
                  ),
                ),
                error: (_, __) => Text(
                  AppAssets.of(context)!.fetchDataFailed,
                  style: const TextStyle(color: Colors.grey),
                ),
                data: (equipments) => _EquipmentDropdown(
                  value:
                      selectedEquipment.value ??
                      (equipments.isNotEmpty ? equipments.first : null),
                  items: equipments,
                  locale: locale,
                  onChanged: (v) => selectedEquipment.value = v,
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: state.isLoading ? AppAssets.of(context)!.creating : AppAssets.of(context)!.create,
                onPressed: state.isLoading ? null : submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EquipmentDropdown extends StatelessWidget {
  const _EquipmentDropdown({
    required this.value,
    required this.items,
    required this.locale,
    required this.onChanged,
  });

  final Equipment? value;
  final List<Equipment> items;
  final String locale;
  final ValueChanged<Equipment> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<Equipment>(
        value: value,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: AppColors.darkSurface,
        style: const TextStyle(color: AppColors.monoWhite, fontSize: 15),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        items: items
            .map(
              (eq) => DropdownMenuItem(
                value: eq,
                child: Text(eq.localizedDisplayName(locale)),
              ),
            )
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }
}
