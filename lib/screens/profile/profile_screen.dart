import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'selection_screen.dart';

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
                if (_isEditing) {
                  // 保存処理
                  userProfileProvider.setSaved(true);
                }
                _isEditing = !_isEditing;
              });
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
              SelectionScreen.buildProfileHeader(context, _isEditing),
              const SizedBox(height: 20),
              SelectionScreen.buildProfileDetails(context, _isEditing),
            ],
          ),
        ),
      ),
    );
  }
}