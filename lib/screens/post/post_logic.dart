import 'package:flutter/material.dart';
import 'tournament_details_screen.dart';
import 'official_tournament_screen.dart';

class PostLogic {
  String searchQuery = '';

  void updateSearchQuery(String query) {
    searchQuery = query;
    // 検索ロジックをここに追加
  }

  void showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('条件検索', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              // 条件検索オプションをここに追加
              ElevatedButton(
                onPressed: () {
                  // 検索を適用するロジック
                  Navigator.pop(context);
                },
                child: const Text('検索を適用'),
              ),
            ],
          ),
        );
      },
    );
  }

  void navigateToTournamentDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TournamentDetailsScreen()),
    );
  }

  void navigateToOfficialTournament(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OfficialTournamentScreen()),
    );
  }
}