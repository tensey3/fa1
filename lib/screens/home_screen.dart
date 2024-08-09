import 'package:flutter/material.dart';
import 'profile/profile_screen.dart'; // ProfileScreenをインポート
import 'match_screen.dart';
import 'chat_screen.dart';
import 'event_screen.dart';
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
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'プロフィール',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'マッチング',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined), // 中央の投稿ボタンのアイコン
            label: '投稿',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'チャット',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'イベント',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}