import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IconChangeLogic {
  final BuildContext context;

  IconChangeLogic(this.context);

  // アイコン変更オプションを表示するメソッド
  void showIconChangeOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('ギャラリーから選択'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('カメラで撮影'),
                onTap: () {
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('削除'),
                onTap: () {
                  removeIcon();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // 画像を選択または撮影するメソッド
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      // アイコンを更新する処理
      // 例えば、ユーザープロフィールに画像パスを保存するなど
      if (context.mounted) {
        Navigator.of(context).pop(); // ボトムシートを閉じる
      }
    }
  }

  // アイコンを削除するメソッド
  void removeIcon() {
    if (context.mounted) {
      Navigator.of(context).pop(); // ボトムシートを閉じる
    }
  }
}