import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'profile_header.dart';
import 'selection_screen.dart';

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
            icon: const Icon(Icons.edit),
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
            _buildProfileDetail('自己紹介', userProfileProvider.bio),
            const SizedBox(height: 10),
            _buildProfileDetail('カラオケスキル', userProfileProvider.karaokeSkillLevel),
            const SizedBox(height: 10),
            _buildProfileDetail('カラオケの頻度', userProfileProvider.karaokeFrequency),
            const SizedBox(height: 10),
            _buildProfileDetail('カラオケの目的', userProfileProvider.karaokePurpose),
            const SizedBox(height: 10),
            _buildProfileDetail('DAM機種', userProfileProvider.selectedDamMachine),
            const SizedBox(height: 10),
            _buildProfileDetail('JOYSOUND機種', userProfileProvider.selectedJoySoundMachine),
            const SizedBox(height: 10),
            _buildProfileDetail('好きなジャンル', userProfileProvider.favoriteGenres.join(', ')),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[900]),
        ),
        Expanded(
          child: Text(
            value.isNotEmpty ? value : '未設定',
            style: TextStyle(fontSize: 16, color: Colors.red[800]),
          ),
        ),
      ],
    );
  }
}