import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodをインポート
import '../../providers/user_profile_provider.dart';
import 'constants.dart';
import 'selection_logic.dart';

class MachineSelection extends ConsumerWidget { // ConsumerWidgetに変更
  final bool isEditing;

  const MachineSelection({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // refを追加
    final userProfile = ref.watch(userProfileProvider); // ref.watchを使用

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '機種はどっち派閥？',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildEditableDropdown(
          label: 'DAM機種',
          value: userProfile.selectedDamMachine.isNotEmpty
              ? userProfile.selectedDamMachine
              : Constants.damMachines[0], // デフォルトの値を設定
          items: Constants.damMachines,
          onChanged: (value) {
            if (value != null) {
              SelectionLogic(ref).setSelectedDamMachine(value); // refを使用
            }
          },
        ),
        const SizedBox(height: 10),
        _buildEditableDropdown(
          label: 'JOYSOUND機種',
          value: userProfile.selectedJoySoundMachine.isNotEmpty
              ? userProfile.selectedJoySoundMachine
              : Constants.joySoundMachines[0], // デフォルトの値を設定
          items: Constants.joySoundMachines,
          onChanged: (value) {
            if (value != null) {
              SelectionLogic(ref).setSelectedJoySoundMachine(value); // refを使用
            }
          },
        ),
      ],
    );
  }

  Widget _buildEditableDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return isEditing
        ? DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: label),
            value: value,
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          )
        : Text(
            '$label: $value',
            style: const TextStyle(fontSize: 16),
          );
  }
}