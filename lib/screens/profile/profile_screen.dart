import 'package:fa1/screens/profile/profile_header.dart';
import 'package:fa1/screens/profile/selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

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
              const ProfileHeader(isEditing: false),
              const SizedBox(height: 20),
              _buildProfileItem('自己紹介', userProfileProvider.bio, const Color(0xFFF06292)), // ピンク色
              _buildProfileItem('カラオケスキル', userProfileProvider.karaokeSkillLevel, const Color(0xFFF06292)), 
              _buildProfileItem('カラオケの頻度', userProfileProvider.karaokeFrequency, const Color(0xFFF06292)), 
              _buildProfileItem('カラオケの目的', userProfileProvider.karaokePurpose, const Color(0xFFF06292)), 
              _buildProfileItem('DAM機種', userProfileProvider.selectedDamMachine, const Color(0xFF4DD0E1)), // ターコイズ色
              _buildProfileItem('JOYSOUND機種', userProfileProvider.selectedJoySoundMachine, const Color(0xFFF06292)), 
              _buildProfileItem('好きなジャンル', userProfileProvider.favoriteGenres.join(', '), const Color(0xFF4DD0E1)), 
              _buildProfileItem('好きな曲', userProfileProvider.favoriteSongs.join(', '), const Color(0xFFF06292)), 

              const SizedBox(height: 20),
              const Divider(
                color: Colors.black38, 
                thickness: 1.0,
              ),
              const SizedBox(height: 10),
              _buildPhotoGridPlaceholder(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFF7043)), // 明るいオレンジ
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : '未設定',
              style: TextStyle(fontSize: 16, color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGridPlaceholder() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), 
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, 
        crossAxisSpacing: 8.0, 
        mainAxisSpacing: 8.0, 
        childAspectRatio: 1.0, 
      ),
      itemCount: 9, 
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[300], 
          child: const Icon(Icons.photo, color: Colors.grey), 
        );
      },
    );
  }
}