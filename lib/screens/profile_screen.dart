import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_profile_provider.dart';
import 'selection/profile_editable_field.dart';
import 'selection/profile_picture_widget.dart';
import 'selection/profile_field_dropdown.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // 保存処理を追加
              // 例: プロフィール情報をサーバーに送信する処理など
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilePictureWidget(
              imagePath: userProfileProvider.profileImagePath,
              onImagePicked: (newImagePath) {
                userProfileProvider.setProfileImage(newImagePath);
              },
            ),
            const SizedBox(height: 20),
            ProfileEditableField(
              label: 'ユーザー名',
              value: userProfileProvider.userName,
              onSave: (newValue) {
                userProfileProvider.setUserName(newValue);
              },
            ),
            const SizedBox(height: 20),
            ProfileEditableField(
              label: '自己紹介',
              value: userProfileProvider.bio,
              maxLines: 3,
              onSave: (newValue) {
                userProfileProvider.setBio(newValue);
              },
            ),
            const SizedBox(height: 20),
            ProfileFieldDropdown(
              label: 'カラオケスキルレベル',
              value: userProfileProvider.karaokeSkillLevel,
              options: const ['初心者', '中級者', '上級者'],
              onChanged: (newValue) {
                userProfileProvider.setKaraokeSkillLevel(newValue!);
              },
            ),
            const SizedBox(height: 20),
            ProfileFieldDropdown(
              label: 'カラオケの頻度',
              value: userProfileProvider.karaokeFrequency,
              options: const ['週に1回', '月に数回', '年に数回'],
              onChanged: (newValue) {
                userProfileProvider.setKaraokeFrequency(newValue!);
              },
            ),
            const SizedBox(height: 20),
            ProfileFieldDropdown(
              label: 'カラオケの目的',
              value: userProfileProvider.karaokePurpose,
              options: const ['楽しむため', '練習のため', '友達と過ごすため', '大会に参加するため'],
              onChanged: (newValue) {
                userProfileProvider.setKaraokePurpose(newValue!);
              },
            ),
            const SizedBox(height: 20),
            ProfileEditableField(
              label: '好きなジャンル',
              value: userProfileProvider.favoriteGenres.join(', '),
              onSave: (newValue) {
                userProfileProvider.setFavoriteGenres(newValue.split(', '));
              },
            ),
          ],
        ),
      ),
    );
  }
}