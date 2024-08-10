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
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SelectionScreen(isEditing: true),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(isEditing: false),
            const SizedBox(height: 20),
            _buildProfileItem('自己紹介', userProfileProvider.bio, Colors.red),
            _buildProfileItem('カラオケスキル', userProfileProvider.karaokeSkillLevel, Colors.red),
            _buildProfileItem('カラオケの頻度', userProfileProvider.karaokeFrequency, Colors.red),
            _buildProfileItem('カラオケの目的', userProfileProvider.karaokePurpose, Colors.red),
            _buildProfileItem('DAM機種', userProfileProvider.selectedDamMachine, Colors.blue),
            _buildProfileItem('JOYSOUND機種', userProfileProvider.selectedJoySoundMachine, Colors.red),
            _buildProfileItem('好きなジャンル', userProfileProvider.favoriteGenres.join(', '), Colors.blue),
            _buildProfileItem('好きな曲', userProfileProvider.favoriteSongs.join(', '), Colors.red), // 好きな曲の表示
          ],
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[900]),
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
}