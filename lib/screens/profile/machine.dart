import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user_profile_provider.dart';
import 'constants.dart';

class MachineSelection extends ConsumerWidget {
  final bool isEditing;

  const MachineSelection({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);
    final selectedCategory = ref.watch(machineCategoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '機種カテゴリーを選択してください',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildCategoryDropdown(
          label: 'カテゴリー',
          value: selectedCategory,
          items: Constants.machineCategories,
          onChanged: (value) {
            if (value != null) {
              ref.read(machineCategoryProvider.notifier).state = value;

              // DAMまたはJOYSOUNDが選択された場合、対応するフィールドを更新
              if (value == 'DAM') {
                ref.read(userProfileProvider.notifier).setSelectedDamMachine('DAM');
              } else if (value == 'JOYSOUND') {
                ref.read(userProfileProvider.notifier).setSelectedJoySoundMachine('JOYSOUND');
              } else if (value == '両方') {
                ref.read(userProfileProvider.notifier).setSelectedDamMachine('DAM');
                ref.read(userProfileProvider.notifier).setSelectedJoySoundMachine('JOYSOUND');
              } else {
                ref.read(userProfileProvider.notifier).setSelectedDamMachine('');
                ref.read(userProfileProvider.notifier).setSelectedJoySoundMachine('');
              }

              // カテゴリー変更時に選択済みの機種をリセット
              ref.read(userProfileProvider.notifier).setSelectedDamMachines([]);
              ref.read(userProfileProvider.notifier).setSelectedJoySoundMachines([]);
            }
          },
        ),
        const SizedBox(height: 10),
        if (selectedCategory != null && (selectedCategory == 'DAM' || selectedCategory == '両方')) ...[
          _buildCheckboxList(
            label: 'DAM機種',
            selectedValues: userProfile.selectedDamMachines,
            items: Constants.damMachines,
            onChanged: (selectedItems) {
              ref.read(userProfileProvider.notifier).setSelectedDamMachines(selectedItems);
            },
          ),
        ],
        if (selectedCategory != null && (selectedCategory == 'JOYSOUND' || selectedCategory == '両方')) ...[
          const SizedBox(height: 10),
          _buildCheckboxList(
            label: 'JOYSOUND機種',
            selectedValues: userProfile.selectedJoySoundMachines,
            items: Constants.joySoundMachines,
            onChanged: (selectedItems) {
              ref.read(userProfileProvider.notifier).setSelectedJoySoundMachines(selectedItems);
            },
          ),
        ],
        if (selectedCategory != null && selectedCategory == 'こだわりはない／どちらでもいい') ...[
          const SizedBox(height: 10),
          const Text(
            'こだわりはないため、特定の機種は選択されません。',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ],
    );
  }

  Widget _buildCategoryDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildCheckboxList({
    required String label,
    required List<String> selectedValues,
    required List<String> items,
    required ValueChanged<List<String>> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...items.map((item) {
          return CheckboxListTile(
            title: Text(item),
            value: selectedValues.contains(item),
            onChanged: (bool? isChecked) {
              final newSelectedValues = List<String>.from(selectedValues);
              if (isChecked == true) {
                newSelectedValues.add(item);
              } else {
                newSelectedValues.remove(item);
              }
              onChanged(newSelectedValues);
            },
          );
        }),
      ],
    );
  }
}

// 状態管理用のProviderを定義
final machineCategoryProvider = StateProvider<String?>((ref) => null);