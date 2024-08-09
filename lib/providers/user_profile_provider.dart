import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  // プロフィール情報
  String _userName = 'ユーザー名';
  String _bio = '';
  String _profileImagePath = '';
  String _karaokeSkillLevel = '初心者';
  String _karaokeFrequency = '週に1回';
  String _karaokePurpose = '楽しむため';

  // リストを final にせず、内部でリストの状態を変更できるようにします。
  List<String> _favoriteSongs = ['よく歌う曲'];
  List<String> _favoriteGenres = ['ポップ'];
  List<RangeValues> _selectedDecadesRanges = [const RangeValues(1940, 2024)];
  List<String> _selectedMachines = [];

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
  List<String> get favoriteSongs => List.unmodifiable(_favoriteSongs); // 不変リストを返す
  List<String> get favoriteGenres => List.unmodifiable(_favoriteGenres); // 不変リストを返す
  List<RangeValues> get selectedDecadesRanges => List.unmodifiable(_selectedDecadesRanges); // 不変リストを返す
  List<String> get selectedMachines => List.unmodifiable(_selectedMachines); // 不変リストを返す
  bool get isUserNameVisible => _isUserNameVisible;
  bool get isSaved => _isSaved;

  String get favoriteSong => _favoriteSongs.isNotEmpty ? _favoriteSongs.first : 'なし';

  // セッター
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setBio(String bio) {
    _bio = bio;
    notifyListeners();
  }

  void setProfileImagePath(String path) {
    _profileImagePath = path;
    notifyListeners();
  }

  void setKaraokeSkillLevel(String level) {
    _karaokeSkillLevel = level;
    notifyListeners();
  }

  void setKaraokeFrequency(String frequency) {
    _karaokeFrequency = frequency;
    notifyListeners();
  }

  void setKaraokePurpose(String purpose) {
    _karaokePurpose = purpose;
    notifyListeners();
  }

  void setFavoriteSongs(List<String> songs) {
    _favoriteSongs = List.from(songs); // 直接リストを再作成
    notifyListeners();
  }

  void addFavoriteSong(String song) {
    _favoriteSongs.add(song);
    notifyListeners();
  }

  void setFavoriteGenres(List<String> genres) {
    _favoriteGenres = List.from(genres); // 直接リストを再作成
    notifyListeners();
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
    _selectedDecadesRanges = List.from(ranges); // 直接リストを再作成
    notifyListeners();
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

  void setSelectedMachines(List<String> machines) {
    _selectedMachines = List.from(machines); // 直接リストを再作成
    notifyListeners();
  }

  void toggleMachine(String machine) {
    if (_selectedMachines.contains(machine)) {
      _selectedMachines.remove(machine);
    } else {
      _selectedMachines.add(machine);
    }
    notifyListeners();
  }

  void toggleUserNameVisibility() {
    _isUserNameVisible = !_isUserNameVisible;
    notifyListeners();
  }

  void setSaved(bool value) {
    _isSaved = value;
    notifyListeners();
  }

  void addMachine(String machine) {
    _selectedMachines.add(machine);
    notifyListeners();
  }
}