import 'package:flutter/material.dart';
import 'create_tournament_logic.dart';

class CreatePostScreen extends StatelessWidget {
  final CreateTournamentLogic logic = CreateTournamentLogic();

  CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('大会一覧'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _buildTournamentList(context),  // 大会リストを表示するウィジェット
              Expanded(
                child: Container(
                  color: Colors.grey[200],  // 下半分は空白にしておくか、他のコンテンツを表示
                ),
              ),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () => logic.navigateToTournamentDetails(context),
              tooltip: '大会を開く',
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTournamentList(BuildContext context) {
    // ダミーデータを使用して表示する
    final tournaments = List.generate(10, (index) => {
          'name': '大会 $index',
          'description': 'これは大会 $index の概要です。',
          'participants': '${index * 10 + 1} / 100 人'
        });

    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,  // 画面の上半分を使用
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tournaments.length,
        itemBuilder: (context, index) {
          final tournament = tournaments[index];
          return _buildTournamentCard(context, tournament);  // context を渡す
        },
      ),
    );
  }

  Widget _buildTournamentCard(BuildContext context, Map<String, String> tournament) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tournament['name']!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              tournament['description']!,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const Spacer(),
            Text(
              '募集人数: ${tournament['participants']}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}