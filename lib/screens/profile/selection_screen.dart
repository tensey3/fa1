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
  SelectionScreenState createState() => SelectionScreenState();
}

class SelectionScreenState extends State<SelectionScreen> {
  TextEditingController? _bioController;
  TextEditingController? _userNameController;
  bool _isGenreVisible = true;
  bool _isDecadeVisible = false;
  bool _isFavoriteSongVisible = false;
  bool _isMachineVisible = false;

  @override
  void initState() {
    super.initState();
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    _bioController = TextEditingController(text: userProfileProvider.bio);
    _userNameController = TextEditingController(text: userProfileProvider.userName);
  }

  @override
  void dispose() {
    _bioController?.dispose();
    _userNameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール設定'),
        backgroundColor: const Color(0xFF40E0D0), // Turquoise (変更)
      ),
      backgroundColor: const Color(0xFF2C2C54), // Dark Navy
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserNameField(),
              const SizedBox(height: 20),
              _buildBioField(),
              const SizedBox(height: 20),
              _buildDropdown(
                label: Constants.karaokeSkillLabel,
                value: userProfileProvider.karaokeSkillLevel,
                items: Constants.karaokeSkillLevels,
                onChanged: (value) => userProfileProvider.setKaraokeSkillLevel(value!),
              ),
              const SizedBox(height: 20),
              _buildDropdown(
                label: Constants.karaokeFrequencyLabel,
                value: userProfileProvider.karaokeFrequency,
                items: Constants.karaokeFrequencies,
                onChanged: (value) => userProfileProvider.setKaraokeFrequency(value!),
              ),
              const SizedBox(height: 20),
              _buildDropdown(
                label: Constants.karaokePurposeLabel,
                value: userProfileProvider.karaokePurpose,
                items: Constants.karaokePurposes,
                onChanged: (value) => userProfileProvider.setKaraokePurpose(value!),
              ),
              const SizedBox(height: 20),
              _buildSectionToggle('ジャンル', _isGenreVisible, () {
                setState(() {
                  _isGenreVisible = !_isGenreVisible;
                });
              }),
              if (_isGenreVisible) GenreSelection(isEditing: widget.isEditing),
              const SizedBox(height: 20),
              _buildSectionToggle('好きな年代', _isDecadeVisible, () {
                setState(() {
                  _isDecadeVisible = !_isDecadeVisible;
                });
              }),
              if (_isDecadeVisible)
                DecadeSelection(
                  isVisible: _isDecadeVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isDecadeVisible = !_isDecadeVisible;
                    });
                  },
                  onSave: (selectedDecadesRanges) {
                    userProfileProvider.setSelectedDecadesRanges(selectedDecadesRanges);
                  },
                ),
              const SizedBox(height: 20),
              _buildSectionToggle('好きな曲', _isFavoriteSongVisible, () {
                setState(() {
                  _isFavoriteSongVisible = !_isFavoriteSongVisible;
                });
              }),
              if (_isFavoriteSongVisible)
                FavoriteSongInput(
                  isVisible: _isFavoriteSongVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isFavoriteSongVisible = !_isFavoriteSongVisible;
                    });
                  },
                  onSave: () {
                    setState(() {
                      _isFavoriteSongVisible = false;
                    });
                  },
                ),
              const SizedBox(height: 20),
              _buildSectionToggle('機種', _isMachineVisible, () {
                setState(() {
                  _isMachineVisible = !_isMachineVisible;
                });
              }),
              if (_isMachineVisible) MachineSelection(isEditing: widget.isEditing),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // ユーザー名と自己紹介の保存
                    userProfileProvider.setUserName(_userNameController!.text);
                    userProfileProvider.setBio(_bioController!.text);
                    userProfileProvider.setSaved(true);
                    Navigator.of(context).pop(); // 編集を終了して戻る
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFFF4500), // Vivid Red
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

  Widget _buildUserNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ユーザー名',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7DF9FF)), // Electric Blue
        ),
        TextField(
          controller: _userNameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Color(0xFF2C2C54), // Dark Navy
            hintText: 'ユーザー名を入力してください',
            hintStyle: TextStyle(color: Color(0xFFD1D1D1)), // Light Silver
          ),
          style: const TextStyle(color: Colors.white), // White
        ),
      ],
    );
  }

  Widget _buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '自己紹介',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7DF9FF)), // Electric Blue
        ),
        TextField(
          controller: _bioController,
          onChanged: (value) {
            // ここでリスナーに通知する場合、必要に応じて変更可能
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Color(0xFF2C2C54), // Dark Navy
            hintText: '自己紹介を入力してください',
            hintStyle: TextStyle(color: Color(0xFFD1D1D1)), // Light Silver
          ),
          style: const TextStyle(color: Colors.white), // White
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7DF9FF)), // Electric Blue
        ),
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Color(0xFF2C2C54), // Dark Navy
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item, style: const TextStyle(color: Colors.white)), // White
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSectionToggle(String label, bool isVisible, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7DF9FF)), // Electric Blue
          ),
          Icon(isVisible ? Icons.expand_less : Icons.expand_more, color: Colors.white), // White
        ],
      ),
    );
  }
}