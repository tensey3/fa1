import 'package:fa1/screens/profile/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'selection_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey[900],
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProfileTile(
            context,
            label: '自己紹介',
            value: userProfileProvider.bio,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SelectionScreen(
                title: '自己紹介を編集',
                initialValue: userProfileProvider.bio,
                onSave: (value) => userProfileProvider.setBio(value),
              ),
            )),
          ),
          const SizedBox(height: 10),
          _buildProfileTile(
            context,
            label: 'カラオケスキル',
            value: userProfileProvider.karaokeSkillLevel,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SelectionScreen(
                title: 'カラオケスキルを編集',
                initialValue: userProfileProvider.karaokeSkillLevel,
                items: Constants.karaokeSkillLevels,
                onSave: (value) => userProfileProvider.setKaraokeSkillLevel(value),
              ),
            )),
          ),
          const SizedBox(height: 10),
          _buildProfileTile(
            context,
            label: 'カラオケの頻度',
            value: userProfileProvider.karaokeFrequency,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SelectionScreen(
                title: 'カラオケの頻度を編集',
                initialValue: userProfileProvider.karaokeFrequency,
                items: Constants.karaokeFrequencies,
                onSave: (value) => userProfileProvider.setKaraokeFrequency(value),
              ),
            )),
          ),
          const SizedBox(height: 10),
          _buildProfileTile(
            context,
            label: 'カラオケの目的',
            value: userProfileProvider.karaokePurpose,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SelectionScreen(
                title: 'カラオケの目的を編集',
                initialValue: userProfileProvider.karaokePurpose,
                items: Constants.karaokePurposes,
                onSave: (value) => userProfileProvider.setKaraokePurpose(value),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTile(BuildContext context,
      {required String label, required String value, required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 14, color: Colors.white70),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
      onTap: onTap,
    );
  }
}