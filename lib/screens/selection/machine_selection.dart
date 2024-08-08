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

  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = context.watch<UserProfileProvider>();
    final List<String> selectedMachines = userProfileProvider.selectedMachines;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onToggleVisibility,
            child: const Text('好きな機種'),
          ),
        ),
        if (widget.isVisible && !_isSaving)
          Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 2,
                itemBuilder: (context, index) {
                  final machineType = index == 0 ? 'DAM' : 'JOYSOUND';
                  final isSelected = selectedMachines.any((machine) => machine.startsWith(machineType));

                  return GestureDetector(
                    onTap: () {
                      if (machineType == 'DAM') {
                        widget.onDamToggleVisibility();
                      } else {
                        widget.onJoySoundToggleVisibility();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          machineType,
                          style: TextStyle(
                            fontSize: 18,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (widget.isDamVisible)
                _buildMachineList(context, _damMachines, widget.onDamToggleVisibility),
              if (widget.isJoySoundVisible)
                _buildMachineList(context, _joySoundMachines, widget.onJoySoundToggleVisibility),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isSaving = true;
                    });
                    widget.onSave();
                    setState(() {
                      _isSaving = false;
                    });
                    widget.onToggleVisibility(); // 保存後にセクションを閉じる
                  },
                  child: const Text('機種を保存'),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildMachineList(BuildContext context, List<String> machines, VoidCallback onToggleVisibility) {
    final userProfileProvider = context.watch<UserProfileProvider>();
    final List<String> selectedMachines = userProfileProvider.selectedMachines;

    return Column(
      children: machines.map((machine) {
        final isSelected = selectedMachines.contains(machine);
        return ListTile(
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
        );
      }).toList(),
    );
  }
}