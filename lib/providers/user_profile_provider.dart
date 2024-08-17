import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final userProfileProvider = StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) {
  return UserProfileNotifier();
});

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

  UserProfile({
    required this.userName,
    required this.bio,
    required this.profileImagePath,
    required this.karaokeSkillLevel,
    required this.karaokeFrequency,
    required this.karaokePurpose,
    required this.selectedDamMachine,
    required this.selectedJoySoundMachine,
    required this.favoriteSongs,
    required this.favoriteGenres,
    required this.selectedDecadesRanges,
    required this.selectedPhotos,
    required this.isUserNameVisible,
    required this.isSaved,
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
    );
  }
}

class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier()
      : super(UserProfile(
          userName: 'ユーザー名',
          bio: '',
          profileImagePath: '',
          karaokeSkillLevel: '初心者',
          karaokeFrequency: '週に1回',
          karaokePurpose: '楽しむため',
          selectedDamMachine: '',
          selectedJoySoundMachine: '',
          favoriteSongs: ['よく歌う曲'],
          favoriteGenres: ['ポップ'],
          selectedDecadesRanges: [const RangeValues(1940, 2024)],
          selectedPhotos: [],
          isUserNameVisible: true,
          isSaved: false,
        ));

  void setUserName(String name) {
    state = state.copyWith(userName: name);
  }

  void setBio(String bio) {
    state = state.copyWith(bio: bio);
  }

  void setProfileImagePath(String path) {
    state = state.copyWith(profileImagePath: path);
  }

  void removeProfileImage() {
    state = state.copyWith(profileImagePath: '');
  }

  void setKaraokeSkillLevel(String level) {
    state = state.copyWith(karaokeSkillLevel: level);
  }

  void setKaraokeFrequency(String frequency) {
    state = state.copyWith(karaokeFrequency: frequency);
  }

  void setKaraokePurpose(String purpose) {
    state = state.copyWith(karaokePurpose: purpose);
  }

  void setSelectedDamMachine(String machine) {
    state = state.copyWith(selectedDamMachine: machine);
  }

  void setSelectedJoySoundMachine(String machine) {
    state = state.copyWith(selectedJoySoundMachine: machine);
  }

  void setFavoriteSongs(List<String> songs) {
    state = state.copyWith(favoriteSongs: List.from(songs));
  }

  void addFavoriteSong(String song) {
    final updatedSongs = List<String>.from(state.favoriteSongs)..add(song);
    state = state.copyWith(favoriteSongs: updatedSongs);
  }

  void setFavoriteGenres(List<String> genres) {
    state = state.copyWith(favoriteGenres: List.from(genres));
  }

  void toggleGenre(String genre) {
    final updatedGenres = List<String>.from(state.favoriteGenres);
    if (updatedGenres.contains(genre)) {
      updatedGenres.remove(genre);
    } else {
      updatedGenres.add(genre);
    }
    state = state.copyWith(favoriteGenres: updatedGenres);
  }

  void setSelectedDecadesRanges(List<RangeValues> ranges) {
    state = state.copyWith(selectedDecadesRanges: List.from(ranges));
  }

  void addDecadeRange(RangeValues range) {
    final updatedRanges = List<RangeValues>.from(state.selectedDecadesRanges)
      ..add(range);
    state = state.copyWith(selectedDecadesRanges: updatedRanges);
  }

  void updateDecadeRange(int index, RangeValues range) {
    final updatedRanges = List<RangeValues>.from(state.selectedDecadesRanges)
      ..[index] = range;
    state = state.copyWith(selectedDecadesRanges: updatedRanges);
  }

  void removeDecadeRange(int index) {
    final updatedRanges = List<RangeValues>.from(state.selectedDecadesRanges)
      ..removeAt(index);
    state = state.copyWith(selectedDecadesRanges: updatedRanges);
  }

  void toggleUserNameVisibility() {
    state = state.copyWith(isUserNameVisible: !state.isUserNameVisible);
  }

  void setSaved(bool value) {
    state = state.copyWith(isSaved: value);
  }

  void updateProfileImage(String path) {
    final updatedPhotos = List<String>.from(state.selectedPhotos)..add(path);
    state = state.copyWith(profileImagePath: path, selectedPhotos: updatedPhotos);
  }
}