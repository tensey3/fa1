// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodをインポート
import '../../providers/user_profile_provider.dart';
import 'constants.dart';

class ProfileDropdown extends ConsumerWidget { // ConsumerWidgetに変更
  final bool isEditing;

  const ProfileDropdown({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // refを追加
    final userProfile = ref.watch(userProfileProvider); // ref.watchを使用

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isEditing
            ? TextField(
                decoration: const InputDecoration(labelText: '自己紹介'),
                controller: TextEditingController(text: userProfile.bio),
                onChanged: (value) => ref.read(userProfileProvider.notifier).setBio(value), // ref.readを使用
              )
            : Text(
                '自己紹介: ${userProfile.bio}',
                style: const TextStyle(fontSize: 16),
              ),
        const SizedBox(height: 10),
        _buildDropdownField(
          context: context,
          label: 'カラオケスキル',
          value: userProfile.karaokeSkillLevel,
          options: Constants.karaokeSkillLevels,
          onChanged: (value) => ref.read(userProfileProvider.notifier).setKaraokeSkillLevel(value!), // ref.readを使用
        ),
        const SizedBox(height: 10),
        _buildDropdownField(
          context: context,
          label: 'カラオケの頻度',
          value: userProfile.karaokeFrequency,
          options: Constants.karaokeFrequencies,
          onChanged: (value) => ref.read(userProfileProvider.notifier).setKaraokeFrequency(value!), // ref.readを使用
        ),
        const SizedBox(height: 10),
        _buildDropdownField(
          context: context,
          label: 'カラオケの目的',
          value: userProfile.karaokePurpose,
          options: Constants.karaokePurposes,
          onChanged: (value) => ref.read(userProfileProvider.notifier).setKaraokePurpose(value!), // ref.readを使用
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