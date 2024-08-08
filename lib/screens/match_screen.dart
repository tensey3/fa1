import 'package:flutter/material.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'どんなお相手を探しますか？',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey[300],
                          child: Center(child: Text('画像 $index')),
                        ),
                      ),
                      ListTile(
                        title: Text('ユーザー $index'),
                        subtitle: const Text('紹介文がここに入ります'),
                      ),
                    ],
                  ),
                );
              },
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
