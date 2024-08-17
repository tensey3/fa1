import 'dart:io';
import 'package:fa1/screens/profile/profile_header.dart';
import 'package:fa1/screens/profile/selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodをインポート
import '../../providers/user_profile_provider.dart'; // プロバイダーのインポート

class ProfileScreen extends ConsumerWidget { // ConsumerWidgetに変更
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // refを追加
    final userProfile = ref.watch(userProfileProvider); // プロバイダーを監視

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        backgroundColor: const Color(0xFFFFA726), // 明るいオレンジ色
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SelectionScreen(isEditing: true),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 35), // サイズ調整
                backgroundColor: const Color(0xFFFF7043), // 少し濃い目のオレンジ色
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              icon: const Icon(Icons.edit, size: 18),
              label: const Text(
                '編集',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [
              Color(0xFFFFF59D), // 明るいイエロー
              Color(0xFFFFFDE7), // 非常に薄いイエロー
            ],
            stops: [0.0, 0.6],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                isEditing: true,
                onImageSelected: (imageFile) {
                  ref.read(userProfileProvider.notifier).updateProfileImage(imageFile); // refを使用して状態を更新
                },
              ),
              const SizedBox(height: 20),
              _buildProfileItem(
                '自己紹介',
                userProfile.bio, // ここでuserProfileを使用
                const Color(0xFFF06292),
                isCentered: true,
              ),
              _buildProfileItem('カラオケスキル', userProfile.karaokeSkillLevel, const Color(0xFFF06292)),
              _buildProfileItem('カラオケの頻度', userProfile.karaokeFrequency, const Color(0xFFF06292)),
              _buildProfileItem('カラオケの目的', userProfile.karaokePurpose, const Color(0xFFF06292)),
              _buildProfileItem('DAM機種', userProfile.selectedDamMachine, const Color(0xFF4DD0E1)),
              _buildProfileItem('JOYSOUND機種', userProfile.selectedJoySoundMachine, const Color(0xFFF06292)),
              _buildProfileItem('好きなジャンル', userProfile.favoriteGenres.join(', '), const Color(0xFF4DD0E1)),
              _buildProfileItem('好きな曲', userProfile.favoriteSongs.join(', '), const Color(0xFFF06292)),

              const SizedBox(height: 20),
              const Divider(
                color: Colors.black38,
                thickness: 1.0,
              ),
              const SizedBox(height: 10),
              _buildPhotoGrid(userProfile.selectedPhotos),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value, Color color, {bool isCentered = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF7043), // 明るいオレンジ
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Container(
            width: isCentered ? 250 : double.infinity, // セレクションの自己紹介と同じサイズ
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.black12, // 枠の黒塗り
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value.isNotEmpty ? value : '未設定',
              style: TextStyle(fontSize: 16, color: color),
              textAlign: isCentered ? TextAlign.center : TextAlign.left,
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGrid(List<String> selectedPhotos) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: selectedPhotos.isEmpty ? 9 : selectedPhotos.length,
      itemBuilder: (context, index) {
        if (selectedPhotos.isEmpty) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.photo, color: Colors.grey),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(selectedPhotos[index])), // ここで選択された写真を表示
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          );
        }
      },
    );
  }
}