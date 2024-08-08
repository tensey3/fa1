import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿作成'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'タイトル'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: '内容'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 投稿作成処理をここに追加
              },
              child: const Text('投稿を作成'),
            ),
          ],
        ),
      ),
    );
  }
}