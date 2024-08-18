import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class UserProfile {
  final String userName;
  final String bio;
  final String profileImagePath;
  final String karaokeSkillLevel;
  final String karaokeFrequency;
  final String karaokePurpose;
  final String selectedDamMachine;
  final String selectedJoySoundMachine;
  final List<String> favoriteSongs;
  final List<String> favoriteGenres;
  final List<RangeValues> selectedDecadesRanges;
  final List<String> selectedPhotos;
  final bool isUserNameVisible;
  final bool isSaved;

  // 追加
  final List<String> selectedDamMachines;
  final List<String> selectedJoySoundMachines;

  UserProfile({
    this.userName = 'ユーザー名',
    this.bio = '',
    this.profileImagePath = '',
    this.karaokeSkillLevel = '初心者',
    this.karaokeFrequency = '週に1回',
    this.karaokePurpose = '楽しむため',
    this.selectedDamMachine = '',
    this.selectedJoySoundMachine = '',
    this.favoriteSongs = const ['よく歌う曲'],
    this.favoriteGenres = const ['ポップ'],
    this.selectedDecadesRanges = const [RangeValues(1940, 2024)],
    this.selectedPhotos = const [],
    this.isUserNameVisible = true,
    this.isSaved = false,
    this.selectedDamMachines = const [],
    this.selectedJoySoundMachines = const [],
  });

  UserProfile copyWith({
    String? userName,
    String? bio,
    String? profileImagePath,
    String? karaokeSkillLevel,
    String? karaokeFrequency,
    String? karaokePurpose,
    String? selectedDamMachine,
    String? selectedJoySoundMachine,
    List<String>? favoriteSongs,
    List<String>? favoriteGenres,
    List<RangeValues>? selectedDecadesRanges,
    List<String>? selectedPhotos,
    bool? isUserNameVisible,
    bool? isSaved,
    List<String>? selectedDamMachines,
    List<String>? selectedJoySoundMachines,
  }) {
    return UserProfile(
      userName: userName ?? this.userName,
      bio: bio ?? this.bio,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      karaokeSkillLevel: karaokeSkillLevel ?? this.karaokeSkillLevel,
      karaokeFrequency: karaokeFrequency ?? this.karaokeFrequency,
      karaokePurpose: karaokePurpose ?? this.karaokePurpose,
      selectedDamMachine: selectedDamMachine ?? this.selectedDamMachine,
      selectedJoySoundMachine: selectedJoySoundMachine ?? this.selectedJoySoundMachine,
      favoriteSongs: favoriteSongs ?? this.favoriteSongs,
      favoriteGenres: favoriteGenres ?? this.favoriteGenres,
      selectedDecadesRanges: selectedDecadesRanges ?? this.selectedDecadesRanges,
      selectedPhotos: selectedPhotos ?? this.selectedPhotos,
      isUserNameVisible: isUserNameVisible ?? this.isUserNameVisible,
      isSaved: isSaved ?? this.isSaved,
      selectedDamMachines: selectedDamMachines ?? this.selectedDamMachines,
      selectedJoySoundMachines: selectedJoySoundMachines ?? this.selectedJoySoundMachines,
    );
  }
}

// プロファイル情報を管理するStateNotifierクラス
class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier() : super(UserProfile());

  // ユーザー名の設定
  void setUserName(String name) {
    _updateProfile(userName: name);
  }

  // 自己紹介の設定
  void setBio(String bio) {
    _updateProfile(bio: bio);
  }
  void addSubPhoto(String path) {
  final updatedPhotos = List<String>.from(state.selectedPhotos)..add(path);
  state = state.copyWith(selectedPhotos: updatedPhotos);
}

void removeSubPhoto(int index) {
  final updatedPhotos = List<String>.from(state.selectedPhotos)..removeAt(index);
  state = state.copyWith(selectedPhotos: updatedPhotos);
}

  // プロフィール画像のパスを設定
  void setProfileImagePath(String path) {
    _updateProfile(profileImagePath: path);
  }

  // プロフィール画像を削除
  void removeProfileImage() {
    _updateProfile(profileImagePath: '');
  }

  // カラオケスキルレベルの設定
  void setKaraokeSkillLevel(String level) {
    _updateProfile(karaokeSkillLevel: level);
  }

  // カラオケの頻度の設定
  void setKaraokeFrequency(String frequency) {
    _updateProfile(karaokeFrequency: frequency);
  }

  // カラオケの目的の設定
  void setKaraokePurpose(String purpose) {
    _updateProfile(karaokePurpose: purpose);
  }

  // DAM機種の設定
  void setSelectedDamMachine(String machine) {
    _updateProfile(selectedDamMachine: machine);
  }

  // JOYSOUND機種の設定
  void setSelectedJoySoundMachine(String machine) {
    _updateProfile(selectedJoySoundMachine: machine);
  }

  // よく歌う曲の設定
  void setFavoriteSongs(List<String> songs) {
    _updateProfile(favoriteSongs: List.from(songs));
  }

  // よく歌う曲を追加
  void addFavoriteSong(String song) {
    final updatedSongs = List<String>.from(state.favoriteSongs)..add(song);
    _updateProfile(favoriteSongs: updatedSongs);
  }

  // DAM機種リストの設定
  void setSelectedDamMachines(List<String> machines) {
    state = state.copyWith(selectedDamMachines: machines);
  }

  // JOYSOUND機種リストの設定
  void setSelectedJoySoundMachines(List<String> machines) {
    state = state.copyWith(selectedJoySoundMachines: machines);
  }

  // 好きなジャンルの設定
  void setFavoriteGenres(List<String> genres) {
    _updateProfile(favoriteGenres: List.from(genres));
  }

  // 好きなジャンルのトグル
  void toggleGenre(String genre) {
    final updatedGenres = List<String>.from(state.favoriteGenres);
    if (updatedGenres.contains(genre)) {
      updatedGenres.remove(genre);
    } else {
      updatedGenres.add(genre);
    }
    _updateProfile(favoriteGenres: updatedGenres);
  }

  // 年代範囲の設定
  void setSelectedDecadesRanges(List<RangeValues> ranges) {
    _updateProfile(selectedDecadesRanges: List.from(ranges));
  }

  // 年代範囲を追加
  void addDecadeRange(RangeValues range) {
    final updatedRanges = List<RangeValues>.from(state.selectedDecadesRanges)..add(range);
    _updateProfile(selectedDecadesRanges: updatedRanges);
  }

  // 年代範囲を更新
  void updateDecadeRange(int index, RangeValues range) {
    final updatedRanges = List<RangeValues>.from(state.selectedDecadesRanges)..[index] = range;
    _updateProfile(selectedDecadesRanges: updatedRanges);
  }

  // 年代範囲を削除
  void removeDecadeRange(int index) {
    final updatedRanges = List<RangeValues>.from(state.selectedDecadesRanges)..removeAt(index);
    _updateProfile(selectedDecadesRanges: updatedRanges);
  }

  // ユーザー名の表示/非表示をトグル
  void toggleUserNameVisibility() {
    _updateProfile(isUserNameVisible: !state.isUserNameVisible);
  }

  // プロフィールが保存されたかどうかを設定
  void setSaved(bool value) {
    _updateProfile(isSaved: value);
  }

  // プロフィール画像の更新
  void updateProfileImage(String path) {
    final updatedPhotos = List<String>.from(state.selectedPhotos)..add(path);
    _updateProfile(profileImagePath: path, selectedPhotos: updatedPhotos);
  }

  // プロファイルを更新するための内部ヘルパーメソッド
  void _updateProfile({
    String? userName,
    String? bio,
    String? profileImagePath,
    String? karaokeSkillLevel,
    String? karaokeFrequency,
    String? karaokePurpose,
    String? selectedDamMachine,
    String? selectedJoySoundMachine,
    List<String>? favoriteSongs,
    List<String>? favoriteGenres,
    List<RangeValues>? selectedDecadesRanges,
    List<String>? selectedPhotos,
    bool? isUserNameVisible,
    bool? isSaved,
  }) {
    state = state.copyWith(
      userName: userName,
      bio: bio,
      profileImagePath: profileImagePath,
      karaokeSkillLevel: karaokeSkillLevel,
      karaokeFrequency: karaokeFrequency,
      karaokePurpose: karaokePurpose,
      selectedDamMachine: selectedDamMachine,
      selectedJoySoundMachine: selectedJoySoundMachine,
      favoriteSongs: favoriteSongs,
      favoriteGenres: favoriteGenres,
      selectedDecadesRanges: selectedDecadesRanges,
      selectedPhotos: selectedPhotos,
      isUserNameVisible: isUserNameVisible,
      isSaved: isSaved,
    );
  }
}

// プロバイダーの定義
final userProfileProvider = StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) {
  return UserProfileNotifier();
});