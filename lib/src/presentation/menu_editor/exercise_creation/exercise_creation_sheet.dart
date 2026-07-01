import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/core/constants/app_color.dart';
import 'package:machamp/src/domain/constants/exercise_constants.dart';
import 'package:machamp/src/presentation/00_components/primary_button.dart';
import 'package:machamp/src/presentation/menu_editor/exercise_creation/exercise_creation_view_model.dart';

class ExerciseCreationSheet extends HookConsumerWidget {
  const ExerciseCreationSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final selectedBodyPart = useState(bodyParts.first);
    final selectedEquipment = useState(equipments.first);

    final state = ref.watch(exerciseCreationViewModelProvider);
    final notifier = ref.read(exerciseCreationViewModelProvider.notifier);

    Future<void> submit() async {
      final name = nameController.text.trim();
      if (name.isEmpty) return;
      final exercise = await notifier.createExercise(
        name: name,
        bodyPart: selectedBodyPart.value,
        equipment: selectedEquipment.value,
      );
      if (exercise != null && context.mounted) {
        Navigator.of(context).pop(exercise);
      } else if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('種目の作成に失敗しました')));
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
              const Center(
                child: Text(
                  'カスタム種目を作成',
                  style: TextStyle(
                    color: AppColors.monoWhite,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '種目名',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: nameController,
                autofocus: true,
                style: const TextStyle(color: AppColors.monoWhite),
                decoration: InputDecoration(
                  hintText: '例: ケーブルクロスオーバー',
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
              const Text(
                '部位',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 6),
              _Dropdown(
                value: selectedBodyPart.value,
                items: bodyParts,
                onChanged: (v) => selectedBodyPart.value = v,
              ),
              const SizedBox(height: 16),
              const Text(
                '器具',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 6),
              _Dropdown(
                value: selectedEquipment.value,
                items: equipments,
                onChanged: (v) => selectedEquipment.value = v,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: state.isLoading ? '作成中...' : '作成する',
                onPressed: state.isLoading ? null : submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  const _Dropdown({
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
      width: double.infinity,
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
        style: const TextStyle(color: AppColors.monoWhite, fontSize: 15),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
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
