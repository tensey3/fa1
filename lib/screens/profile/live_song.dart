import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodをインポート
import '../../providers/user_profile_provider.dart';
import 'selection_logic.dart';

class FavoriteSongInput extends ConsumerStatefulWidget { // ConsumerStatefulWidgetに変更
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

class FavoriteSongInputState extends ConsumerState<FavoriteSongInput> { // ConsumerStateに変更
  final List<TextEditingController> _controllers = [];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final favoriteSongs = ref.read(userProfileProvider).favoriteSongs; // ref.readを使用
    _controllers.addAll(favoriteSongs.map((song) => TextEditingController(text: song)).toList());
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
    List<String> favoriteSongs = _controllers.map((controller) => controller.text).toList();
    SelectionLogic(ref).saveFavoriteSongs(favoriteSongs); // 直接refを使用
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