import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  // プロフィール情報
  String _userName = 'ユーザー名';
  String _bio = '';
  String _profileImagePath = '';
  String _karaokeSkillLevel = '初心者';
  String _karaokeFrequency = '週に1回';
  String _karaokePurpose = '楽しむため';
  String _selectedDamMachine = '';
  String _selectedJoySoundMachine = '';

  // その他の情報
  List<String> _favoriteSongs = ['よく歌う曲'];
  List<String> _favoriteGenres = ['ポップ'];
  List<RangeValues> _selectedDecadesRanges = [const RangeValues(1940, 2024)];

  // プロフィールの表示設定
  bool _isUserNameVisible = true;
  bool _isSaved = false;

  // ゲッター
  String get userName => _userName;
  String get bio => _bio;
  String get profileImagePath => _profileImagePath;
  String get karaokeSkillLevel => _karaokeSkillLevel;
  String get karaokeFrequency => _karaokeFrequency;
  String get karaokePurpose => _karaokePurpose;
  String get selectedDamMachine => _selectedDamMachine;
  String get selectedJoySoundMachine => _selectedJoySoundMachine;
  List<String> get favoriteSongs => List.unmodifiable(_favoriteSongs); // 不変リストを返す
  List<String> get favoriteGenres => List.unmodifiable(_favoriteGenres); // 不変リストを返す
  List<RangeValues> get selectedDecadesRanges => List.unmodifiable(_selectedDecadesRanges); // 不変リストを返す
  bool get isUserNameVisible => _isUserNameVisible;
  bool get isSaved => _isSaved;

  // セッター
  void setUserName(String name) {
    if (_userName != name && name.isNotEmpty) {
      _userName = name;
      notifyListeners();
    }
  }

  void setBio(String bio) {
    if (_bio != bio) {
      _bio = bio;
      notifyListeners();
    }
  }

  void setProfileImagePath(String path) {
    if (_profileImagePath != path && path.isNotEmpty) {
      _profileImagePath = path;
      notifyListeners();
    }
  }

  void setKaraokeSkillLevel(String level) {
    if (_karaokeSkillLevel != level && level.isNotEmpty) {
      _karaokeSkillLevel = level;
      notifyListeners();
    }
  }

  void setKaraokeFrequency(String frequency) {
    if (_karaokeFrequency != frequency && frequency.isNotEmpty) {
      _karaokeFrequency = frequency;
      notifyListeners();
    }
  }

  void setKaraokePurpose(String purpose) {
    if (_karaokePurpose != purpose && purpose.isNotEmpty) {
      _karaokePurpose = purpose;
      notifyListeners();
    }
  }

  void setSelectedDamMachine(String machine) {
    if (_selectedDamMachine != machine && machine.isNotEmpty) {
      _selectedDamMachine = machine;
      notifyListeners();
    }
  }

  void setSelectedJoySoundMachine(String machine) {
    if (_selectedJoySoundMachine != machine && machine.isNotEmpty) {
      _selectedJoySoundMachine = machine;
      notifyListeners();
    }
  }

  void setFavoriteSongs(List<String> songs) {
    if (!_listsAreEqual(_favoriteSongs, songs)) {
      _favoriteSongs = List.from(songs); // リストを新しくコピー
      notifyListeners();
    }
  }

  void addFavoriteSong(String song) {
    if (!_favoriteSongs.contains(song)) {
      _favoriteSongs.add(song);
      notifyListeners();
    }
  }

  void setFavoriteGenres(List<String> genres) {
    if (!_listsAreEqual(_favoriteGenres, genres)) {
      _favoriteGenres = List.from(genres); // リストを新しくコピー
      notifyListeners();
    }
  }

  void toggleGenre(String genre) {
    if (_favoriteGenres.contains(genre)) {
      _favoriteGenres.remove(genre);
    } else {
      _favoriteGenres.add(genre);
    }
    notifyListeners();
  }

  void setSelectedDecadesRanges(List<RangeValues> ranges) {
    if (!_rangesAreEqual(_selectedDecadesRanges, ranges)) {
      _selectedDecadesRanges = List.from(ranges); // リストを新しくコピー
      notifyListeners();
    }
  }

  void addDecadeRange(RangeValues range) {
    _selectedDecadesRanges.add(range);
    notifyListeners();
  }

  void updateDecadeRange(int index, RangeValues range) {
    if (index >= 0 && index < _selectedDecadesRanges.length) {
      _selectedDecadesRanges[index] = range;
      notifyListeners();
    }
  }

  void removeDecadeRange(int index) {
    if (index >= 0 && index < _selectedDecadesRanges.length) {
      _selectedDecadesRanges.removeAt(index);
      notifyListeners();
    }
  }

  void toggleUserNameVisibility() {
    _isUserNameVisible = !_isUserNameVisible;
    notifyListeners();
  }

  void setSaved(bool value) {
    if (_isSaved != value) {
      _isSaved = value;
      notifyListeners();
    }
  }

  // 内部ユーティリティメソッド
  bool _listsAreEqual(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  bool _rangesAreEqual(List<RangeValues> list1, List<RangeValues> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].start != list2[i].start || list1[i].end != list2[i].end) {
        return false;
      }
    }
    return true;
  }
}