import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'post_logic.dart';
import '../../providers/event_provider.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  CreatePostScreenState createState() => CreatePostScreenState(); // アンダースコアを削除
}

class CreatePostScreenState extends ConsumerState<CreatePostScreen> { // アンダースコアを削除
  final logic = PostLogic();

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('大会一覧'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _buildSearchBar(context, logic),
              _buildTournamentList(context, events),  // 大会リストを表示するウィジェット
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
              onPressed: () {
                logic.navigateToTournamentDetails(context);
              },
              tooltip: '大会を開く',
              child: const Icon(Icons.add),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: () {
                logic.navigateToOfficialTournament(context);
              },
              child: const Text('公式大会'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, PostLogic logic) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'どんなお相手を探しますか？',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                logic.updateSearchQuery(value);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              logic.showFilterOptions(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTournamentList(BuildContext context, Map<DateTime, List<Event>> events) {
    final allEvents = events.values.expand((eventList) => eventList).toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,  // 画面の上半分を使用
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allEvents.length,
        itemBuilder: (context, index) {
          final event = allEvents[index];
          return _buildTournamentCard(context, event);
        },
      ),
    );
  }

  Widget _buildTournamentCard(BuildContext context, Event event) {
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
              event.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              event.description.isNotEmpty ? event.description : '説明なし',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const Spacer(),
            Text(
              '募集人数: ${event.participants}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            _buildRegistrationDeadlineTimer(event.registrationDeadline), // タイマーを追加
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationDeadlineTimer(DateTime registrationDeadline) {
    return TweenAnimationBuilder<Duration>(
      duration: registrationDeadline.difference(DateTime.now()),
      tween: Tween(begin: registrationDeadline.difference(DateTime.now()), end: Duration.zero),
      onEnd: () {
        // 応募締め切りが過ぎた場合の処理
      },
      builder: (BuildContext context, Duration value, Widget? child) {
        final minutes = value.inMinutes.remainder(60);
        final hours = value.inHours.remainder(24);
        final days = value.inDays;
        return Text('応募締め切りまで: $days日 $hours時間 $minutes分');
      },
    );
  }
}