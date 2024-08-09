import 'package:fa1/screens/profile/selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SelectionScreen(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(isEditing: false),
            const SizedBox(height: 20),
            _buildProfileDetail(
                '自己紹介', userProfileProvider.bio),
            _buildProfileDetail(
                'カラオケスキル', userProfileProvider.karaokeSkillLevel),
            _buildProfileDetail(
                'カラオケの頻度', userProfileProvider.karaokeFrequency),
            _buildProfileDetail(
                'カラオケの目的', userProfileProvider.karaokePurpose),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        '$label: ${value ?? '未設定'}',
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}