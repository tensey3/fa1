import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreateTournamentLogic {
  String tournamentName = '';
  String tournamentDetails = '';

  void setTournamentName(String name) {
    tournamentName = name;
  }

  void setTournamentDetails(String details) {
    tournamentDetails = details;
  }

  void createTournament() {
    // ここに大会作成のビジネスロジックを追加
    if (kDebugMode) {
      print('大会を作成しました: $tournamentName - $tournamentDetails');
    }
  }

  void navigateToTournamentDetails(BuildContext context) {
    // 大会の詳細設定画面に遷移するためのロジック
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TournamentDetailsScreen()),
    );
  }
}

class TournamentDetailsScreen extends StatelessWidget {
  const TournamentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('大会の詳細設定'),
      ),
      body: const Center(
        child: Text('ここに大会の詳細設定を行うUIを配置'),
      ),
    );
  }
}