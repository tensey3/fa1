import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'decade_selection.dart';
import 'genre_selection.dart';
import 'live_song.dart';
import 'machine_selection.dart';
import 'name.dart';

class SelectionScreen extends StatelessWidget {
  final VoidCallback onSave;

  const SelectionScreen({
    super.key,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          UserNameInput(
            isVisible: true,
            onToggleVisibility: () {},
            onSave: onSave,
          ),
          FavoriteSongInput(
            isVisible: true,
            onToggleVisibility: () {},
            onSave: onSave,
          ),
          GenreSelection(
            isVisible: true,
            onToggleVisibility: () {},
            onSave: (selectedGenres) {
              Provider.of<UserProfileProvider>(context, listen: false).setFavoriteGenres(selectedGenres);
              onSave();
            },
          ),
          DecadeSelection(
            isVisible: true,
            onToggleVisibility: () {},
            onSave: (selectedDecadesRanges) {
              Provider.of<UserProfileProvider>(context, listen: false).setSelectedDecadesRanges(selectedDecadesRanges);
              onSave();
            },
          ),
          MachineSelection(
            isVisible: true,
            isDamVisible: true,
            isJoySoundVisible: true,
            onToggleVisibility: () {},
            onDamToggleVisibility: () {},
            onJoySoundToggleVisibility: () {},
            onSave: onSave,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSave,
              child: const Text('全ての設定を保存'),
            ),
          ),
        ],
      ),
    );
  }
}