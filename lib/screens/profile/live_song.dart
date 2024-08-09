import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';

class FavoriteSongInput extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onSave;

  const FavoriteSongInput({
    super.key,
    required this.isVisible,
    required this.onToggleVisibility,
    required this.onSave,
  });

  @override
  FavoriteSongInputState createState() => FavoriteSongInputState();
}

class FavoriteSongInputState extends State<FavoriteSongInput> {
  final List<TextEditingController> _controllers = [];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    _controllers.addAll(userProfileProvider.favoriteSongs
        .map((song) => TextEditingController(text: song))
        .toList());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addNewTextField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _saveFavoriteSongs() {
    setState(() {
      _isSaving = true;
    });
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    List<String> favoriteSongs = _controllers.map((controller) => controller.text).toList();
    userProfileProvider.setFavoriteSongs(favoriteSongs);
    setState(() {
      _isSaving = false;
      widget.onSave(); // 保存後にセクションを閉じる
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onToggleVisibility,
            child: const Text('よく歌う曲を入力'),
          ),
        ),
        if (widget.isVisible)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'よく歌う曲を入力してください:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ..._controllers.map((controller) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.start,
                    ),
                  )),
              IconButton(
                onPressed: _addNewTextField,
                icon: const Icon(Icons.add),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveFavoriteSongs,
                  child: _isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('曲を保存'),
                ),
              ),
            ],
          ),
      ],
    );
  }
}