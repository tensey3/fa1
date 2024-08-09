import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';

class MachineSelection extends StatefulWidget {
  final bool isVisible;
  final bool isDamVisible;
  final bool isJoySoundVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onDamToggleVisibility;
  final VoidCallback onJoySoundToggleVisibility;
  final VoidCallback onSave;

  const MachineSelection({
    super.key,
    required this.isVisible,
    required this.isDamVisible,
    required this.isJoySoundVisible,
    required this.onToggleVisibility,
    required this.onDamToggleVisibility,
    required this.onJoySoundToggleVisibility,
    required this.onSave,
  });

  @override
  MachineSelectionState createState() => MachineSelectionState();
}

class MachineSelectionState extends State<MachineSelection> {
  static const List<String> _damMachines = [
    'LIVE DAM AiR（DAM-XG8000R）',
    'LIVE DAM Ai（DAM-XG8000）',
    'Cyber DAM +（DAM-G100W）',
  ];

  static const List<String> _joySoundMachines = [
    'JOYSOUND X1',
    'JOYSOUND MAX GO',
    'JOYSOUND 響Ⅱ',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isVisible) ...[
          _buildMachineCategoryButton('DAM', widget.onDamToggleVisibility, widget.isDamVisible),
          if (widget.isDamVisible) _buildMachineList(context, _damMachines),
          const SizedBox(height: 10),
          _buildMachineCategoryButton('JOYSOUND', widget.onJoySoundToggleVisibility, widget.isJoySoundVisible),
          if (widget.isJoySoundVisible) _buildMachineList(context, _joySoundMachines),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onSave,
              child: const Text('機種を保存'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMachineCategoryButton(String category, VoidCallback onToggleVisibility, bool isVisible) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isVisible ? Colors.blueAccent : Colors.grey[300],
          foregroundColor: Colors.black,
        ),
        onPressed: onToggleVisibility,
        child: Text(category),
      ),
    );
  }

  Widget _buildMachineList(BuildContext context, List<String> machines) {
    final userProfileProvider = context.watch<UserProfileProvider>();

    return Column(
      children: machines.map((machine) {
        final isSelected = userProfileProvider.selectedMachines.contains(machine);
        return ListTile(
          title: Text(machine),
          leading: Checkbox(
            value: isSelected,
            onChanged: (bool? value) {
              setState(() {
                userProfileProvider.toggleMachine(machine);
              });
            },
          ),
          selected: isSelected,
          onTap: () {
            setState(() {
              userProfileProvider.toggleMachine(machine);
            });
          },
        );
      }).toList(),
    );
  }
}