import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';

class UserNameInput extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onToggleVisibility;
  final VoidCallback onSave;

  const UserNameInput({
    super.key,
    required this.isVisible,
    required this.onToggleVisibility,
    required this.onSave,
  });

  @override
  UserNameInputState createState() => UserNameInputState();
}

class UserNameInputState extends State<UserNameInput> {
  late TextEditingController _userNameController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    _userNameController = TextEditingController(text: userProfileProvider.userName);
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  void _saveUserName(String name) {
    setState(() {
      _isSaving = true;
    });

    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.setUserName(name);

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
            child: const Text('ユーザー名を入力'),
          ),
        ),
        if (widget.isVisible)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ユーザー名を入力してください:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _userNameController,
                textAlign: TextAlign.start,
                onChanged: (text) {
                  // テキストフィールドの変更を反映する場合は、必要に応じて処理を追加
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving
                      ? null
                      : () => _saveUserName(_userNameController.text),
                  child: _isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('ユーザー名を保存'),
                ),
              ),
            ],
          ),
      ],
    );
  }
}