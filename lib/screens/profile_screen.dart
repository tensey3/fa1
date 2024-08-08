import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_profile_provider.dart';
import 'selection/selection_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.settings),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
              if (!_isEditing) {
                // 保存が押されたときに設定を保存
                userProfileProvider.setSaved(true);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(userProfileProvider),
              const SizedBox(height: 20),
              if (_isEditing)
                SelectionScreen(
                  onSave: () {
                    setState(() {
                      _isEditing = false;
                    });
                  },
                )
              else
                _buildProfileDetails(userProfileProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(UserProfileProvider userProfileProvider) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/images/profile_picture.png'),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userProfileProvider.userName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'ステータス: ${userProfileProvider.favoriteSong}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileDetails(UserProfileProvider userProfileProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '自己紹介: ${userProfileProvider.bio}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          'カラオケスキル: ${userProfileProvider.karaokeSkillLevel}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          'カラオケの頻度: ${userProfileProvider.karaokeFrequency}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          'カラオケの目的: ${userProfileProvider.karaokePurpose}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        _buildGenresSection(userProfileProvider),
        const SizedBox(height: 20),
        _buildDecadesSection(userProfileProvider),
        const SizedBox(height: 20),
        _buildMachinesSection(userProfileProvider),
      ],
    );
  }

  Widget _buildGenresSection(UserProfileProvider userProfileProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '好きなジャンル:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          children: userProfileProvider.favoriteGenres.map((genre) {
            return Chip(
              label: Text(genre),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDecadesSection(UserProfileProvider userProfileProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '好きな年代:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          children: userProfileProvider.selectedDecadesRanges.map((range) {
            return Chip(
              label: Text('${range.start.round()} - ${range.end.round()}'),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMachinesSection(UserProfileProvider userProfileProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '好きな機種:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          children: userProfileProvider.selectedMachines.map((machine) {
            return Chip(
              label: Text(machine),
            );
          }).toList(),
        ),
      ],
    );
  }
}