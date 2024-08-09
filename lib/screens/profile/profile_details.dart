import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'constants.dart';

class ProfileDetails extends StatelessWidget {
  final bool isEditing;

  const ProfileDetails({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isEditing
            ? TextField(
                decoration: const InputDecoration(labelText: '自己紹介'),
                controller: TextEditingController(text: userProfileProvider.bio),
                onChanged: (value) => userProfileProvider.setBio(value),
              )
            : Text(
                '自己紹介: ${userProfileProvider.bio}',
                style: const TextStyle(fontSize: 16),
              ),
        const SizedBox(height: 10),
        _buildEditableDropdown(
          context: context,
          label: 'カラオケスキル',
          value: userProfileProvider.karaokeSkillLevel,
          items: Constants.karaokeSkillLevels,
          onChanged: (value) => userProfileProvider.setKaraokeSkillLevel(value!),
        ),
        const SizedBox(height: 10),
        _buildEditableDropdown(
          context: context,
          label: 'カラオケの頻度',
          value: userProfileProvider.karaokeFrequency,
          items: Constants.karaokeFrequencies,
          onChanged: (value) => userProfileProvider.setKaraokeFrequency(value!),
        ),
        const SizedBox(height: 10),
        _buildEditableDropdown(
          context: context,
          label: 'カラオケの目的',
          value: userProfileProvider.karaokePurpose,
          items: Constants.karaokePurposes,
          onChanged: (value) => userProfileProvider.setKaraokePurpose(value!),
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