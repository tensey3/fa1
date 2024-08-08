import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'decade_selection.dart';
import 'genre_selection.dart';
import 'live_song.dart';
import 'machine_selection.dart';
import 'name.dart';

class SelectionScreen extends StatefulWidget {
  final VoidCallback onSave;

  const SelectionScreen({
    super.key,
    required this.onSave,
  });

  @override
  SelectionScreenState createState() => SelectionScreenState();
}

class SelectionScreenState extends State<SelectionScreen> {
  final Map<String, bool> _visibilityMap = {
    'name': false,
    'favoriteSong': false,
    'genre': false,
    'decade': false,
    'machine': false,
    'dam': false,
    'joysound': false,
  };

  void _toggleVisibility(String section) {
    setState(() {
      _visibilityMap[section] = !_visibilityMap[section]!;
    });
  }

  void _saveAllSettings() {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider
      ..setUserName(userProfileProvider.userName)
      ..setFavoriteSongs(userProfileProvider.favoriteSongs)
      ..setFavoriteGenres(userProfileProvider.favoriteGenres) // 修正箇所
      ..setSelectedDecadesRanges(userProfileProvider.selectedDecadesRanges)
      ..setSelectedMachines(userProfileProvider.selectedMachines);
    widget.onSave();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          UserNameInput(
            isVisible: _visibilityMap['name']!,
            onToggleVisibility: () => _toggleVisibility('name'),
            onSave: () {
              _toggleVisibility('name'); // 保存後にセクションを閉じる
            },
          ),
          FavoriteSongInput(
            isVisible: _visibilityMap['favoriteSong']!,
            onToggleVisibility: () => _toggleVisibility('favoriteSong'),
            onSave: () {
              _toggleVisibility('favoriteSong'); // 保存後にセクションを閉じる
            },
          ),
          GenreSelection(
            isVisible: _visibilityMap['genre']!,
            onToggleVisibility: () => _toggleVisibility('genre'),
            onSave: (selectedGenres) {
              Provider.of<UserProfileProvider>(context, listen: false).setFavoriteGenres(selectedGenres); // 修正箇所
              _toggleVisibility('genre');
            },
          ),
          DecadeSelection(
            isVisible: _visibilityMap['decade']!,
            onToggleVisibility: () => _toggleVisibility('decade'),
            onSave: (selectedDecadesRanges) {
              Provider.of<UserProfileProvider>(context, listen: false).setSelectedDecadesRanges(selectedDecadesRanges);
              _toggleVisibility('decade');
            },
          ),
          MachineSelection(
            isVisible: _visibilityMap['machine']!,
            isDamVisible: _visibilityMap['dam']!,
            isJoySoundVisible: _visibilityMap['joysound']!,
            onToggleVisibility: () => _toggleVisibility('machine'),
            onDamToggleVisibility: () => _toggleVisibility('dam'),
            onJoySoundToggleVisibility: () => _toggleVisibility('joysound'),
            onSave: () => _toggleVisibility('machine'),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveAllSettings,
              child: const Text('全ての設定を保存'),
            ),
          ),
        ],
      ),
    );
  }
}