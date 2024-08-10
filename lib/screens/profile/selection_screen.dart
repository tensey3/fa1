import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'genre_selection.dart';
import 'decade_selection.dart';
import 'live_song.dart';
import 'machine.dart';

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
              GenreSelection(isEditing: isEditing),
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
              MachineSelection(isEditing: isEditing),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
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
}