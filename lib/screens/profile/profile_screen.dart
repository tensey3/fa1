import 'package:fa1/screens/profile/profile_header.dart';
import 'package:fa1/screens/profile/selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // UserProfileProviderを使用してユーザープロフィールデータを取得
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      // アプリのトップバー（AppBar）を設定
      appBar: AppBar(
        title: const Text('プロフィール'),
        backgroundColor: const Color(0xFF40E0D0), // Turquoise色の背景色
        actions: [
          // 設定ボタンが右上に表示され、押すとSelectionScreenに移動
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
      // 背景にグラデーションを設定
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [
              Color(0xFFFFB6C1), // Light Pink: ピンクに近い色でグラデーションの開始
              Color(0xFFFFFFFF), // White: グラデーションの終わりの色
            ],
            stops: [0.0, 0.6], // グラデーションの幅を指定、中央で終わるように設定
          ),
        ),
        // コンテンツをスクロールできるようにSingleChildScrollViewを使用
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0), // 全体のパディングを設定
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // プロフィールヘッダー部分（名前や画像）の表示
              const ProfileHeader(isEditing: false),
              const SizedBox(height: 20),
              
              // プロフィール情報の各項目を表示
              _buildProfileItem('自己紹介', userProfileProvider.bio, const Color(0xFFFF6F61)), // Salmon Pink
              _buildProfileItem('カラオケスキル', userProfileProvider.karaokeSkillLevel, const Color(0xFFFF6F61)), // Salmon Pink
              _buildProfileItem('カラオケの頻度', userProfileProvider.karaokeFrequency, const Color(0xFFFF6F61)), // Salmon Pink
              _buildProfileItem('カラオケの目的', userProfileProvider.karaokePurpose, const Color(0xFFFF6F61)), // Salmon Pink
              _buildProfileItem('DAM機種', userProfileProvider.selectedDamMachine, const Color(0xFF40E0D0)), // Turquoise
              _buildProfileItem('JOYSOUND機種', userProfileProvider.selectedJoySoundMachine, const Color(0xFFFF6F61)), // Salmon Pink
              _buildProfileItem('好きなジャンル', userProfileProvider.favoriteGenres.join(', '), const Color(0xFF40E0D0)), // Turquoise
              _buildProfileItem('好きな曲', userProfileProvider.favoriteSongs.join(', '), const Color(0xFFFF6F61)), // Salmon Pink
              
              const SizedBox(height: 20),
              // 境目に水平線を追加
              const Divider(
                color: Colors.black26, // 薄い黒色の線
                thickness: 1.0,
              ),
              const SizedBox(height: 10),
              // 写真を配置するためのスペースを確保
              _buildPhotoGridPlaceholder(),
            ],
          ),
        ),
      ),
    );
  }

  // 各プロフィール項目を表示するためのメソッド
  Widget _buildProfileItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ラベル部分を表示
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7DF9FF)), // Electric Blue
          ),
          // 値部分を表示、設定されていない場合は「未設定」と表示
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

  // 写真を配置するためのスペースを仮に作成するメソッド
  Widget _buildPhotoGridPlaceholder() {
    return GridView.builder(
      shrinkWrap: true, // GridViewがスクロール領域内に収まるように
      physics: const NeverScrollableScrollPhysics(), // GridView自体はスクロールさせない
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3列で表示
        crossAxisSpacing: 8.0, // 横方向の間隔
        mainAxisSpacing: 8.0, // 縦方向の間隔
        childAspectRatio: 1.0, // 縦横比を1:1に設定（正方形）
      ),
      itemCount: 9, // 仮の9つの写真スペース
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[300], // 仮の背景色（薄いグレー）
          child: const Icon(Icons.photo, color: Colors.grey), // 仮のアイコン（写真の代わり）
        );
      },
    );
  }
}