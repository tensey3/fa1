import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'profile_editable_field.dart';
import 'profile_field_dropdown.dart';
import 'profile_picture_widget.dart';
import 'constants.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール設定'),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey[850],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilePictureWidget(
              imagePath: userProfileProvider.profileImagePath,
              onImagePicked: (path) => userProfileProvider.setProfileImagePath(path),
            ),
            const SizedBox(height: 20),
            ProfileEditableField(
              label: 'ユーザー名',
              value: userProfileProvider.userName,
              onSave: (value) => userProfileProvider.setUserName(value),
            ),
            const SizedBox(height: 20),
            ProfileEditableField(
              label: '自己紹介',
              value: userProfileProvider.bio,
              maxLines: 3,
              onSave: (value) => userProfileProvider.setBio(value),
            ),
            const SizedBox(height: 20),
            ProfileFieldDropdown(
              label: 'カラオケスキル',
              value: userProfileProvider.karaokeSkillLevel,
              options: Constants.karaokeSkillLevels,
              onChanged: (value) => userProfileProvider.setKaraokeSkillLevel(value!),
            ),
            const SizedBox(height: 20),
            ProfileFieldDropdown(
              label: 'カラオケの頻度',
              value: userProfileProvider.karaokeFrequency,
              options: Constants.karaokeFrequencies,
              onChanged: (value) => userProfileProvider.setKaraokeFrequency(value!),
            ),
            const SizedBox(height: 20),
            ProfileFieldDropdown(
              label: 'カラオケの目的',
              value: userProfileProvider.karaokePurpose,
              options: Constants.karaokePurposes,
              onChanged: (value) => userProfileProvider.setKaraokePurpose(value!),
            ),
            const SizedBox(height: 20),
            // 他の設定項目も追加可能
          ],
        ),
      ),
    );
  }
}