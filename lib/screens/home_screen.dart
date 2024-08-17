import 'package:flutter/material.dart';
import 'profile/profile_screen.dart'; // ProfileScreenをインポート
import 'match_screen.dart';
import 'chat_screen.dart';
import 'event/event_screen.dart';
import 'create_post_screen.dart'; // CreatePostScreenをインポート

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const ProfileScreen(),
    const MatchScreen(),
    const CreatePostScreen(), // 中央の投稿ボタンを押した時の画面
    const ChatScreen(),
    const EventScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'プロフィール',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'マッチング',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber[800],
              ),
              child: const Icon(Icons.add_box_outlined, color: Colors.white),
            ),
            label: '投稿',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'チャット',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'イベント',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        backgroundColor: Colors.black87,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}