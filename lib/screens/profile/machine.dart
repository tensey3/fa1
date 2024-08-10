import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'constants.dart';
import 'selection_logic.dart';

class MachineSelection extends StatelessWidget {
  final bool isEditing;

  const MachineSelection({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '機種はどっち派閥？',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildEditableDropdown(
          context: context,
          label: 'DAM機種',
          value: userProfileProvider.selectedDamMachine.isNotEmpty
              ? userProfileProvider.selectedDamMachine
              : Constants.damMachines[0], // デフォルトの値を設定
          items: Constants.damMachines,
          onChanged: (value) {
            if (value != null) {
              SelectionLogic(context).setSelectedDamMachine(value);
            }
          },
        ),
        const SizedBox(height: 10),
        _buildEditableDropdown(
          context: context,
          label: 'JOYSOUND機種',
          value: userProfileProvider.selectedJoySoundMachine.isNotEmpty
              ? userProfileProvider.selectedJoySoundMachine
              : Constants.joySoundMachines[0], // デフォルトの値を設定
          items: Constants.joySoundMachines,
          onChanged: (value) {
            if (value != null) {
              SelectionLogic(context).setSelectedJoySoundMachine(value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildEditableDropdown({
    required BuildContext context,
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