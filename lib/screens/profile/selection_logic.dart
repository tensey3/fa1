// lib/screens/selection_logic.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_profile_provider.dart';

class SelectionLogic {
  final BuildContext context;

  SelectionLogic(this.context);

  // ジャンルのトグル処理
  void toggleGenre(String genre) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.toggleGenre(genre);
  }

  // 年代の保存処理
  void saveDecades(List<RangeValues> selectedDecadesRanges) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.setSelectedDecadesRanges(selectedDecadesRanges);
  }

  // 年代範囲の追加処理
  void addDecadeRange() {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.addDecadeRange(const RangeValues(1940, 2024));
  }

  // 年代範囲の更新処理
  void updateDecadeRange(int index, RangeValues values) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.updateDecadeRange(index, values);
  }

  // 年代範囲の削除処理
  void removeDecadeRange(int index) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.removeDecadeRange(index);
  }

  // よく歌う曲の保存処理
  void saveFavoriteSongs(List<String> favoriteSongs) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.setFavoriteSongs(favoriteSongs);
  }

  // DAM機種の選択処理
  void setSelectedDamMachine(String value) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.setSelectedDamMachine(value);
  }

  // JOYSOUND機種の選択処理
  void setSelectedJoySoundMachine(String value) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.setSelectedJoySoundMachine(value);
  }
}