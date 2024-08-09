import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'constants.dart';  // 定数をインポート

class MachineSelection extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onSave;

  const MachineSelection({
    super.key,
    required this.isVisible,
    required this.onToggleVisibility,
    required this.onSave,
  });

  @override
  MachineSelectionState createState() => MachineSelectionState();
}

class MachineSelectionState extends State<MachineSelection> {
  bool isDamVisible = false;
  bool isJoySoundVisible = false;

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = context.watch<UserProfileProvider>();

    return Column(
      children: [
        if (widget.isVisible) ...[
          _buildMachineCategoryButton('DAM', () {
            setState(() {
              isDamVisible = !isDamVisible;
            });
          }, isDamVisible),
          if (isDamVisible) _buildMachineList(context, Constants.damMachines, userProfileProvider),
          const SizedBox(height: 10),
          _buildMachineCategoryButton('JOYSOUND', () {
            setState(() {
              isJoySoundVisible = !isJoySoundVisible;
            });
          }, isJoySoundVisible),
          if (isJoySoundVisible) _buildMachineList(context, Constants.joySoundMachines, userProfileProvider),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: widget.onSave,
              child: const Text('機種を保存'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMachineCategoryButton(String category, VoidCallback onToggleVisibility, bool isVisible) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isVisible ? Colors.blueAccent : Colors.grey[300],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
          ),
          onPressed: onToggleVisibility,
          child: Text(
            category,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildMachineList(BuildContext context, List<String> machines, UserProfileProvider userProfileProvider) {
    return Column(
      children: machines.map((machine) {
        final isSelected = userProfileProvider.selectedMachines.contains(machine);
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: isSelected ? Colors.blueAccent : Colors.grey,
              width: 2.0,
            ),
          ),
          child: ListTile(
            title: Text(machine),
            leading: Checkbox(
              value: isSelected,
              onChanged: (bool? value) {
                userProfileProvider.toggleMachine(machine);
              },
            ),
            selected: isSelected,
            onTap: () {
              userProfileProvider.toggleMachine(machine);
            },
          ),
        );
      }).toList(),
    );
  }
}