import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'genre_selection.dart';
import 'decade_selection.dart';
import 'live_song.dart';
import 'machine.dart';
import 'constants.dart';

class SelectionScreen extends StatelessWidget {
  final bool isEditing;

  const SelectionScreen({super.key, required this.isEditing});

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
              // 自己紹介の編集フィールド
              _buildTextField(
                label: '自己紹介',
                initialValue: userProfileProvider.bio,
                onChanged: (value) => userProfileProvider.setBio(value),
              ),
              const SizedBox(height: 20),

              // カラオケスキルの編集フィールド
              _buildDropdown(
                label: 'カラオケスキル',
                value: userProfileProvider.karaokeSkillLevel,
                items: Constants.karaokeSkillLevels,
                onChanged: (value) => userProfileProvider.setKaraokeSkillLevel(value!),
              ),
              const SizedBox(height: 20),

              // カラオケの頻度の編集フィールド
              _buildDropdown(
                label: 'カラオケの頻度',
                value: userProfileProvider.karaokeFrequency,
                items: Constants.karaokeFrequencies,
                onChanged: (value) => userProfileProvider.setKaraokeFrequency(value!),
              ),
              const SizedBox(height: 20),

              // カラオケの目的の編集フィールド
              _buildDropdown(
                label: 'カラオケの目的',
                value: userProfileProvider.karaokePurpose,
                items: Constants.karaokePurposes,
                onChanged: (value) => userProfileProvider.setKaraokePurpose(value!),
              ),
              const SizedBox(height: 20),

              // 好きなジャンル
              GenreSelection(isEditing: isEditing),
              const SizedBox(height: 20),

              // 年代選択セクション
              DecadeSelection(
                isVisible: true,
                onToggleVisibility: () {},
                onSave: (selectedDecadesRanges) {
                  userProfileProvider.setSelectedDecadesRanges(selectedDecadesRanges);
                },
              ),
              const SizedBox(height: 20),

              // よく歌う曲入力セクション
              FavoriteSongInput(
                isVisible: true,
                onToggleVisibility: () {},
                onSave: () {
                  // 必要に応じて追加の保存処理を実装
                },
              ),
              const SizedBox(height: 20),

              // カラオケ機種選択セクション
              MachineSelection(isEditing: isEditing),
              const SizedBox(height: 20),

              // 保存ボタン
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // プロフィールの保存処理
                    userProfileProvider.setSaved(true);
                    Navigator.of(context).pop(); // 編集を終了して戻る
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

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[900]),
        ),
        TextField(
          controller: TextEditingController(text: initialValue),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
            hintText: '入力してください',
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