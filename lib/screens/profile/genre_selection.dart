import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';

class GenreSelection extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onToggleVisibility;
  final ValueChanged<List<String>> onSave;

  const GenreSelection({
    super.key,
    required this.isVisible,
    required this.onToggleVisibility,
    required this.onSave,
  });

  @override
  GenreSelectionState createState() => GenreSelectionState();
}

class GenreSelectionState extends State<GenreSelection> {
  static const List<String> _genres = [
    'ポップ',
    'ロック',
    'ジャズ',
    'ヒップホップ',
    'クラシック',
    '演歌',
    'アニメ',
    'VOCALOID',
  ];

  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = context.watch<UserProfileProvider>();
    final selectedGenres = userProfileProvider.favoriteGenres; // selectedGenresをfavoriteGenresに変更

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onToggleVisibility,
            child: const Text('ジャンル選択'),
          ),
        ),
        if (widget.isVisible && !_isSaving)
          Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _genres.length,
                itemBuilder: (context, index) {
                  final genre = _genres[index];
                  final isSelected = selectedGenres.contains(genre);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        userProfileProvider.toggleGenre(genre);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey,
                          width: 2,
                        ),
                      ),
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
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isSaving = true;
                    });
                    widget.onSave(selectedGenres);
                    widget.onToggleVisibility();
                    setState(() {
                      _isSaving = false;
                    });
                  },
                  child: const Text('ジャンルを保存'),
                ),
              ),
            ],
          ),
      ],
    );
  }
}