import 'package:fa1/screens/profile/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'profile_picture_widget.dart';
import 'profile_editable_field.dart';
import 'profile_field_dropdown.dart';


class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール設定'),
        backgroundColor: Colors.black87,  // プロフィール画面と同じ色
      ),
      backgroundColor: Colors.grey[900],  // プロフィール画面と同じ色
      body: Padding(
        padding: const EdgeInsets.all(16.0),  // プロフィール画面と同じパディング
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilePictureWidget(
              imagePath: userProfileProvider.profileImagePath,
              onImagePicked: (path) => userProfileProvider.setProfileImagePath(path),
              borderColor: Colors.white,  // プロフィール画面に合わせたボーダー
            ),
            const SizedBox(height: 20),
            ProfileEditableField(
              label: 'ユーザー名',
              value: userProfileProvider.userName,
              onSave: (value) => userProfileProvider.setUserName(value),
              textStyle: const TextStyle(fontSize: 16, color: Colors.white),  // プロフィール画面に合わせたテキストスタイル
            ),
            const SizedBox(height: 20),
            ProfileEditableField(
              label: '自己紹介',
              value: userProfileProvider.bio,
              maxLines: 3,
              onSave: (value) => userProfileProvider.setBio(value),
              textStyle: const TextStyle(fontSize: 16, color: Colors.white),  // プロフィール画面に合わせたテキストスタイル
            ),
            const SizedBox(height: 20),
            ProfileFieldDropdown(
              label: 'カラオケスキル',
              value: userProfileProvider.karaokeSkillLevel,
              options: Constants.karaokeSkillLevels,
              onChanged: (value) => userProfileProvider.setKaraokeSkillLevel(value!),
              textStyle: const TextStyle(fontSize: 16, color: Colors.white),  // プロフィール画面に合わせたテキストスタイル
            ),
            const SizedBox(height: 20),
            ProfileFieldDropdown(
              label: 'カラオケの頻度',
              value: userProfileProvider.karaokeFrequency,
              options: Constants.karaokeFrequencies,
              onChanged: (value) => userProfileProvider.setKaraokeFrequency(value!),
              textStyle: const TextStyle(fontSize: 16, color: Colors.white),  // プロフィール画面に合わせたテキストスタイル
            ),
            const SizedBox(height: 20),
            ProfileFieldDropdown(
              label: 'カラオケの目的',
              value: userProfileProvider.karaokePurpose,
              options: Constants.karaokePurposes,
              onChanged: (value) => userProfileProvider.setKaraokePurpose(value!),
              textStyle: const TextStyle(fontSize: 16, color: Colors.white),  // プロフィール画面に合わせたテキストスタイル
            ),
          ],
        ),
      ),
    );
  }
}