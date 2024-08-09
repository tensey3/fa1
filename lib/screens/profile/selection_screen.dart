import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'machine_selection.dart';

class SelectionScreen extends StatelessWidget {
  final bool isEditing;

  const SelectionScreen({
    super.key,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    // userProfileProvider を削除します。
    // final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProfileHeader(context, isEditing),
          const SizedBox(height: 20),
          buildProfileDetails(context, isEditing),
          const SizedBox(height: 20),
          MachineSelection(
            isVisible: true,
            isDamVisible: false,
            isJoySoundVisible: false,
            onToggleVisibility: () {},
            onDamToggleVisibility: () {},
            onJoySoundToggleVisibility: () {},
            onSave: () {},
          ),
        ],
      ),
    );
  }

  static Widget buildProfileHeader(BuildContext context, bool isEditing) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Row(
      children: [
        GestureDetector(
          onTap: isEditing ? () => _changeProfileImage(context) : null,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: userProfileProvider.profileImagePath.isNotEmpty
                ? FileImage(File(userProfileProvider.profileImagePath))
                : const AssetImage('assets/images/profile_picture.png') as ImageProvider,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: isEditing
              ? TextField(
                  decoration: const InputDecoration(labelText: 'ユーザー名'),
                  controller: TextEditingController(text: userProfileProvider.userName),
                  onChanged: (value) => userProfileProvider.setUserName(value),
                )
              : Text(
                  userProfileProvider.userName,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
        ),
      ],
    );
  }

  static Widget buildProfileDetails(BuildContext context, bool isEditing) {
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
        buildEditableDropdown(
          context: context,
          label: 'カラオケスキル',
          value: userProfileProvider.karaokeSkillLevel,
          items: ['初心者', '中級者', '上級者'],
          onChanged: (value) => userProfileProvider.setKaraokeSkillLevel(value!),
          isEditing: isEditing,
        ),
        const SizedBox(height: 10),
        buildEditableDropdown(
          context: context,
          label: 'カラオケの頻度',
          value: userProfileProvider.karaokeFrequency,
          items: ['週に1回', '月に1回', 'たまに'],
          onChanged: (value) => userProfileProvider.setKaraokeFrequency(value!),
          isEditing: isEditing,
        ),
        const SizedBox(height: 10),
        buildEditableDropdown(
          context: context,
          label: 'カラオケの目的',
          value: userProfileProvider.karaokePurpose,
          items: ['楽しむため', '練習のため', '友達と'],
          onChanged: (value) => userProfileProvider.setKaraokePurpose(value!),
          isEditing: isEditing,
        ),
        const SizedBox(height: 20),
        buildGenresSection(context, isEditing),
        const SizedBox(height: 20),
        buildDecadesSection(context, isEditing),
        const SizedBox(height: 20),
        buildMachinesSection(context, isEditing),
      ],
    );
  }

  static Widget buildEditableDropdown({
    required BuildContext context,
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required bool isEditing,
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

  static Widget buildGenresSection(BuildContext context, bool isEditing) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '好きなジャンル:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          children: userProfileProvider.favoriteGenres.map((genre) {
            return InputChip(
              label: Text(genre),
              selected: true,
              onSelected: isEditing
                  ? (selected) {
                      userProfileProvider.toggleGenre(genre);
                    }
                  : null,
            );
          }).toList(),
        ),
      ],
    );
  }

  static Widget buildDecadesSection(BuildContext context, bool isEditing) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '好きな年代:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          children: userProfileProvider.selectedDecadesRanges.map((range) {
            return Chip(
              label: Text('${range.start.round()} - ${range.end.round()}'),
              onDeleted: isEditing
                  ? () {
                      userProfileProvider.removeDecadeRange(userProfileProvider.selectedDecadesRanges.indexOf(range));
                    }
                  : null,
            );
          }).toList(),
        ),
        if (isEditing)
          TextButton(
            onPressed: () {
              userProfileProvider.addDecadeRange(const RangeValues(1940, 2024));
            },
            child: const Text('年代を追加'),
          ),
      ],
    );
  }

  static Widget buildMachinesSection(BuildContext context, bool isEditing) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '好きな機種:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          children: userProfileProvider.selectedMachines.map((machine) {
            return InputChip(
              label: Text(machine),
              selected: true,
              onSelected: isEditing
                  ? (selected) {
                      userProfileProvider.toggleMachine(machine);
                    }
                  : null,
            );
          }).toList(),
        ),
        if (isEditing)
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MachineSelection(
                  isVisible: true,
                  isDamVisible: false,
                  isJoySoundVisible: false,
                  onToggleVisibility: () {},
                  onDamToggleVisibility: () {},
                  onJoySoundToggleVisibility: () {},
                  onSave: () {},
                ),
              ));
            },
            child: const Text('機種を追加'),
          ),
      ],
    );
  }

  static void _changeProfileImage(BuildContext context) {
    // プロフィール画像の変更処理
  }
}