import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodをインポート
import '../../providers/user_profile_provider.dart';
import 'genre_selection.dart';
import 'decade_selection.dart';
import 'live_song.dart';
import 'machine.dart';
import 'constants.dart';

class SelectionScreen extends ConsumerStatefulWidget { // ConsumerStatefulWidgetに変更
  final bool isEditing;

  const SelectionScreen({super.key, required this.isEditing});

  @override
  SelectionScreenState createState() => SelectionScreenState();
}

class SelectionScreenState extends ConsumerState<SelectionScreen> { // ConsumerStateに変更
  TextEditingController? _bioController;
  TextEditingController? _userNameController;
  bool _isGenreVisible = true;
  bool _isDecadeVisible = false;
  bool _isFavoriteSongVisible = false;
  bool _isMachineVisible = false;

  @override
  void initState() {
    super.initState();
    // 初期化は ref.read から行う
    final userProfile = ref.read(userProfileProvider); // ref.readを使用して初期化
    _bioController = TextEditingController(text: userProfile.bio);
    _userNameController = TextEditingController(text: userProfile.userName);
  }

  @override
  void dispose() {
    _bioController?.dispose();
    _userNameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider); // ref.watchを使用

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
              _buildUserNameField(),
              const SizedBox(height: 20),
              _buildBioField(),
              const SizedBox(height: 20),
              _buildDropdown(
                label: Constants.karaokeSkillLabel,
                value: userProfile.karaokeSkillLevel,
                items: Constants.karaokeSkillLevels,
                onChanged: (value) => ref.read(userProfileProvider.notifier).setKaraokeSkillLevel(value!), // ref.readを使用
              ),
              const SizedBox(height: 20),
              _buildDropdown(
                label: Constants.karaokeFrequencyLabel,
                value: userProfile.karaokeFrequency,
                items: Constants.karaokeFrequencies,
                onChanged: (value) => ref.read(userProfileProvider.notifier).setKaraokeFrequency(value!), // ref.readを使用
              ),
              const SizedBox(height: 20),
              _buildDropdown(
                label: Constants.karaokePurposeLabel,
                value: userProfile.karaokePurpose,
                items: Constants.karaokePurposes,
                onChanged: (value) => ref.read(userProfileProvider.notifier).setKaraokePurpose(value!), // ref.readを使用
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
                    ref.read(userProfileProvider.notifier).setSelectedDecadesRanges(selectedDecadesRanges); // ref.readを使用
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
                    ref.read(userProfileProvider.notifier).setUserName(_userNameController!.text);
                    ref.read(userProfileProvider.notifier).setBio(_bioController!.text);
                    ref.read(userProfileProvider.notifier).setSaved(true);
                    Navigator.of(context).pop(); // 編集を終了して戻る
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red[800],
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
        Text(
          'ユーザー名',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[900]),
        ),
        TextField(
          controller: _userNameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
            hintText: 'ユーザー名を入力してください',
          ),
        ),
      ],
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
          maxLength: 300, // 文字数制限を300に設定
          maxLines: null, // 自動で下に拡張されるように設定
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

  Widget _buildSectionToggle(String label, bool isVisible, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[900]),
          ),
          Icon(isVisible ? Icons.expand_less : Icons.expand_more),
        ],
      ),
    );
  }
}