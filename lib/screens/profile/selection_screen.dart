import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'genre_selection.dart';
import 'decade_selection.dart';
import 'live_song.dart';
import 'machine.dart';
import 'constants.dart';

class SelectionScreen extends StatefulWidget {
  final bool isEditing;

  const SelectionScreen({super.key, required this.isEditing});

  @override
  // ignore: library_private_types_in_public_api
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    _bioController = TextEditingController(text: userProfileProvider.bio);
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール設定'),
        backgroundColor: Colors.blue[900],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBioField(),
              const SizedBox(height: 20),
              _buildDropdown(
                label: 'カラオケスキル',
                value: userProfileProvider.karaokeSkillLevel,
                items: Constants.karaokeSkillLevels,
                onChanged: (value) => userProfileProvider.setKaraokeSkillLevel(value!),
              ),
              const SizedBox(height: 20),
              _buildDropdown(
                label: 'カラオケの頻度',
                value: userProfileProvider.karaokeFrequency,
                items: Constants.karaokeFrequencies,
                onChanged: (value) => userProfileProvider.setKaraokeFrequency(value!),
              ),
              const SizedBox(height: 20),
              _buildDropdown(
                label: 'カラオケの目的',
                value: userProfileProvider.karaokePurpose,
                items: Constants.karaokePurposes,
                onChanged: (value) => userProfileProvider.setKaraokePurpose(value!),
              ),
              const SizedBox(height: 20),
              GenreSelection(isEditing: widget.isEditing),
              const SizedBox(height: 20),
              DecadeSelection(
                isVisible: true,
                onToggleVisibility: () {},
                onSave: (selectedDecadesRanges) {
                  userProfileProvider.setSelectedDecadesRanges(selectedDecadesRanges);
                },
              ),
              const SizedBox(height: 20),
              FavoriteSongInput(
                isVisible: true,
                onToggleVisibility: () {},
                onSave: () {
                  // 必要に応じて追加の保存処理を実装
                },
              ),
              const SizedBox(height: 20),
              MachineSelection(isEditing: widget.isEditing),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    userProfileProvider.setBio(_bioController.text); // Bioの保存
                    userProfileProvider.setSaved(true);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red[800],
                  ),
                  child: const Text('保存'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '自己紹介',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[900]),
        ),
        TextField(
          controller: _bioController,
          onChanged: (value) {
            // ここでリスナーに通知する場合、必要に応じて変更可能
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
            hintText: '自己紹介を入力してください',
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[900]),
        ),
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}