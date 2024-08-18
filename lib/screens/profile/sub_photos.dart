import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../providers/user_profile_provider.dart';

class SubPhotos extends ConsumerWidget {
  final bool isEditing;
  final void Function(String imagePath)? onSubImageSelected;

  const SubPhotos({
    super.key,
    required this.isEditing,
    this.onSubImageSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'サブ写真',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildSubPhotoGrid(userProfile.selectedPhotos, ref),
        if (isEditing)
          ElevatedButton.icon(
            onPressed: () => _showSubImageOptions(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('サブ写真を追加'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFA726), // オレンジ色に変更
              foregroundColor: Colors.white, // 白い文字色
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
      ],
    );
  }

  void _showSubImageOptions(BuildContext context, WidgetRef ref) {
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
                  Navigator.of(context).pop(); // ダイアログを閉じる
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('カメラで撮影'),
                onTap: () {
                  _pickImage(context, ref, ImageSource.camera);
                  Navigator.of(context).pop(); // ダイアログを閉じる
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
      final selectedPhotos = ref.read(userProfileProvider).selectedPhotos;

      // 画像を追加する前に、すでにリストに追加されているかどうかをチェックする
      if (!selectedPhotos.contains(pickedFile.path)) {
        provider.addSubPhoto(pickedFile.path);
        // onSubImageSelected を削除して、重複呼び出しを防止
      }
    }
  }

  Widget _buildSubPhotoGrid(List<String> subPhotos, WidgetRef ref) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: subPhotos.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(subPhotos[index])),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            if (isEditing)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    ref.read(userProfileProvider.notifier).removeSubPhoto(index);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 15,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}