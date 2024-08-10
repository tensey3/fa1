// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'constants.dart';

class ProfileDropdown extends StatelessWidget {
  final bool isEditing;

  const ProfileDropdown({super.key, required this.isEditing});

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
        _buildDropdownField(
          context: context,
          label: 'カラオケスキル',
          value: userProfileProvider.karaokeSkillLevel,
          options: Constants.karaokeSkillLevels,
          onChanged: (value) => userProfileProvider.setKaraokeSkillLevel(value!),
        ),
        const SizedBox(height: 10),
        _buildDropdownField(
          context: context,
          label: 'カラオケの頻度',
          value: userProfileProvider.karaokeFrequency,
          options: Constants.karaokeFrequencies,
          onChanged: (value) => userProfileProvider.setKaraokeFrequency(value!),
        ),
        const SizedBox(height: 10),
        _buildDropdownField(
          context: context,
          label: 'カラオケの目的',
          value: userProfileProvider.karaokePurpose,
          options: Constants.karaokePurposes,
          onChanged: (value) => userProfileProvider.setKaraokePurpose(value!),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}