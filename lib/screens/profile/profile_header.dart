import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../providers/user_profile_provider.dart'; // 正しいパスでインポート

class ProfileHeader extends ConsumerWidget {
  final bool isEditing;

  const ProfileHeader({
    super.key,
    required this.isEditing,
    required this.onImageSelected,
  });

  final void Function(String imagePath) onImageSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider); // プロバイダーを監視

    return GestureDetector(
      onTap: isEditing ? () => _showImageOptions(context, ref) : null,
      child: Stack(
        children: [
          _buildProfileImage(userProfile.profileImagePath), // プロフィール画像を構築
          if (isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _showImageOptions(context, ref),
                child: const CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 15,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showImageOptions(BuildContext context, WidgetRef ref) {
    final provider = ref.read(userProfileProvider.notifier); // 状態を取得

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('ライブラリから選択'),
                onTap: () {
                  _pickImage(context, ref, ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('カメラで撮影'),
                onTap: () {
                  _pickImage(context, ref, ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              if (provider.state.profileImagePath.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('画像を削除'),
                  onTap: () {
                    provider.removeProfileImage();
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(BuildContext context, WidgetRef ref, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final provider = ref.read(userProfileProvider.notifier);
      provider.setProfileImagePath(pickedFile.path);
      onImageSelected(pickedFile.path);
    }
  }

  Widget _buildProfileImage(String imagePath) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: imagePath.isNotEmpty
          ? FileImage(File(imagePath)) as ImageProvider
          : const AssetImage('/Users/kikuchitensei/fa1/assets/images/null_icon.png'),
      backgroundColor: Colors.grey[200],
    );
  }

}