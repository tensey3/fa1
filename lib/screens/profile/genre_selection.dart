import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';
import 'constants.dart';
import 'selection_logic.dart'; // 新しく作成したファイルをインポート

class GenreSelection extends StatelessWidget {
  final bool isEditing;

  const GenreSelection({
    super.key,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    final selectedGenres = context.watch<UserProfileProvider>().favoriteGenres;

    return DefaultTabController(
      length: Constants.genres.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: Constants.genres.map((genre) {
              return Tab(
                text: genre,
                icon: selectedGenres.contains(genre)
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.circle_outlined, color: Colors.grey),
              );
            }).toList(),
          ),
          SizedBox(
            height: 200,
            child: TabBarView(
              children: Constants.genres.map((genre) {
                return GenreContent(
                  genre: genre,
                  isEditing: isEditing,
                  onGenreSelected: () {
                    SelectionLogic(context).toggleGenre(genre);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class GenreContent extends StatelessWidget {
  final String genre;
  final bool isEditing;
  final VoidCallback onGenreSelected;

  const GenreContent({
    super.key,
    required this.genre,
    required this.isEditing,
    required this.onGenreSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = context.watch<UserProfileProvider>().favoriteGenres.contains(genre);

    return GestureDetector(
      onTap: isEditing ? onGenreSelected : null,
      child: Container(
        color: isSelected ? Colors.blueAccent : Colors.grey[300],
        child: Center(
          child: Text(
            genre,
            style: TextStyle(
              fontSize: 18,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}