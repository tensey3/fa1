import 'package:fa1/screens/profile/profile_header.dart';
import 'package:fa1/screens/profile/selection_screen.dart';
import 'package:fa1/screens/profile/sub_photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user_profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);

    // 好きな機種の表示内容を決定
    String favoriteMachine = '未設定';
    if (userProfile.selectedDamMachine.isNotEmpty && userProfile.selectedJoySoundMachine.isEmpty) {
      favoriteMachine = 'DAM';
    } else if (userProfile.selectedDamMachine.isEmpty && userProfile.selectedJoySoundMachine.isNotEmpty) {
      favoriteMachine = 'JOYSOUND';
    } else if (userProfile.selectedDamMachine.isNotEmpty && userProfile.selectedJoySoundMachine.isNotEmpty) {
      favoriteMachine = 'DAM, JOYSOUND';
    }

    // こだわり機種の表示内容を決定
    final selectedSpecificMachine = [
      if (userProfile.selectedDamMachines.isNotEmpty)
        userProfile.selectedDamMachines.join(', '),
      if (userProfile.selectedJoySoundMachines.isNotEmpty)
        userProfile.selectedJoySoundMachines.join(', '),
    ].join(', ');

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
                  ref.read(userProfileProvider.notifier).updateProfileImage(imageFile);
                },
              ),
              const SizedBox(height: 20),
              _buildProfileItem('自己紹介', userProfile.bio, const Color(0xFFF06292), isCentered: true),
              _buildProfileItem('好きな機種', favoriteMachine, const Color(0xFF4DD0E1)),

              if (selectedSpecificMachine.isNotEmpty)
                _buildProfileItem('こだわり機種', selectedSpecificMachine, const Color(0xFFF06292)),

              _buildProfileItem('カラオケスキル', userProfile.karaokeSkillLevel, const Color(0xFFF06292)),
              _buildProfileItem('カラオケの頻度', userProfile.karaokeFrequency, const Color(0xFFF06292)),
              _buildProfileItem('カラオケの目的', userProfile.karaokePurpose, const Color(0xFFF06292)),
              _buildProfileItem('好きなジャンル', userProfile.favoriteGenres.join(', '), const Color(0xFF4DD0E1)),
              _buildProfileItem('好きな曲', userProfile.favoriteSongs.join(', '), const Color(0xFFF06292)),

              const SizedBox(height: 20),
              const Divider(color: Colors.black38, thickness: 1.0),
              const SizedBox(height: 10),
              SubPhotos(
                isEditing: true, // サブ写真を編集可能
                onSubImageSelected: (imageFile) {
                  ref.read(userProfileProvider.notifier).addSubPhoto(imageFile);
                },
              ),
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
              color: Color(0xFFFF7043), // 明るいオレンジ色
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Container(
            width: isCentered ? 250 : double.infinity,
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
}