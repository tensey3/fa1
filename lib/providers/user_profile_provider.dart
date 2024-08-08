import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  // プロフィール情報
  String _userName = 'ユーザー名';
  String _bio = '';  // プロフィールの自己紹介文
  String _profileImagePath = '';  // プロフィール画像のパス
  String _karaokeSkillLevel = '初心者';  // カラオケのスキルレベル
  String _karaokeFrequency = '週に1回';  // カラオケの頻度
  String _karaokePurpose = '楽しむため';  // カラオケの目的

  // 不変のリストを使用して、変更されないことを保証
  final List<String> _favoriteSongs = ['よく歌う曲'];  // よく歌う曲
  final List<String> _favoriteGenres = ['ポップ'];  // 好きなジャンル
  final List<RangeValues> _selectedDecadesRanges = [const RangeValues(1940, 2024)];  // 好きな年代
  final List<String> _selectedMachines = [];  // 好きな機種

  // プロフィールの表示設定
  bool _isUserNameVisible = true;  // ユーザー名の表示・非表示を管理
  bool _isSaved = false;  // 保存状態を管理

  // ゲッター
  String get userName => _userName;
  String get bio => _bio;
  String get profileImagePath => _profileImagePath;
  String get karaokeSkillLevel => _karaokeSkillLevel;
  String get karaokeFrequency => _karaokeFrequency;
  String get karaokePurpose => _karaokePurpose;
  List<String> get favoriteSongs => _favoriteSongs;
  List<String> get favoriteGenres => _favoriteGenres;
  List<RangeValues> get selectedDecadesRanges => _selectedDecadesRanges;
  List<String> get selectedMachines => _selectedMachines;
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

  void setProfileImage(String path) {
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
    _favoriteSongs
      ..clear()  // リストをクリア
      ..addAll(songs);  // 新しいリストを追加
    notifyListeners();
  }

  void addFavoriteSong(String song) {
    _favoriteSongs.add(song);
    notifyListeners();
  }

  void setFavoriteGenres(List<String> genres) {
    _favoriteGenres
      ..clear()  // リストをクリア
      ..addAll(genres);  // 新しいリストを追加
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
    _selectedDecadesRanges
      ..clear()  // リストをクリア
      ..addAll(ranges);  // 新しいリストを追加
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
    _selectedMachines
      ..clear()  // リストをクリア
      ..addAll(machines);  // 新しいリストを追加
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
}