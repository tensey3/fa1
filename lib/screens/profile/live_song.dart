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
  UserProfileProvider? _userProfileProvider;

  @override
  void initState() {
    super.initState();
    // コントローラの初期化は didChangeDependencies で行う
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_userProfileProvider == null) {
      _userProfileProvider = Provider.of<UserProfileProvider>(context);
      _controllers.addAll(_userProfileProvider!.favoriteSongs
          .map((song) => TextEditingController(text: song))
          .toList());
      _userProfileProvider!.addListener(_onSaveComplete);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _userProfileProvider?.removeListener(_onSaveComplete);
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
    _userProfileProvider!.setFavoriteSongs(favoriteSongs);
    _userProfileProvider!.setSaved(true); // 保存完了を通知
  }

  void _onSaveComplete() {
    if (_userProfileProvider!.isSaved) {
      setState(() {
        _isSaving = false;
      });
      widget.onToggleVisibility(); // 保存後にセクションを閉じる
      _userProfileProvider!.setSaved(false); // フラグをリセット
    }
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
                      onChanged: (text) {
                        // テキストフィールドの変更を反映する場合は、必要に応じて処理を追加
                      },
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