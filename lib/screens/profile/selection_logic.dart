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
    _logAction('Genre toggled', genre);
  }

  // 年代の保存処理
  void saveDecades(List<RangeValues> selectedDecadesRanges) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.setSelectedDecadesRanges(selectedDecadesRanges);
    _logAction('Decades saved', selectedDecadesRanges.toString());
  }

  // 年代範囲の追加処理
  void addDecadeRange() {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.addDecadeRange(const RangeValues(1940, 2024));
    _logAction('Decade range added', '1940 - 2024');
  }

  // 年代範囲の更新処理
  void updateDecadeRange(int index, RangeValues values) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    if (index >= 0 && index < userProfileProvider.selectedDecadesRanges.length) {
      userProfileProvider.updateDecadeRange(index, values);
      _logAction('Decade range updated', '$index: ${values.start} - ${values.end}');
    } else {
      _logError('Invalid index for updating decade range', index.toString());
    }
  }

  // 年代範囲の削除処理
  void removeDecadeRange(int index) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    if (index >= 0 && index < userProfileProvider.selectedDecadesRanges.length) {
      userProfileProvider.removeDecadeRange(index);
      _logAction('Decade range removed', index.toString());
    } else {
      _logError('Invalid index for removing decade range', index.toString());
    }
  }

  // よく歌う曲の保存処理
  void saveFavoriteSongs(List<String> favoriteSongs) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.setFavoriteSongs(favoriteSongs);
    _logAction('Favorite songs saved', favoriteSongs.join(', '));
  }

  // DAM機種の選択処理
  void setSelectedDamMachine(String value) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.setSelectedDamMachine(value);
    _logAction('Selected DAM machine', value);
  }

  // JOYSOUND機種の選択処理
  void setSelectedJoySoundMachine(String value) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProfileProvider.setSelectedJoySoundMachine(value);
    _logAction('Selected JOYSOUND machine', value);
  }

  // デバッグ用のアクションログ
  void _logAction(String action, String details) {
    debugPrint('[$action] - $details');
  }

  // デバッグ用のエラーログ
  void _logError(String error, String details) {
    debugPrint('[ERROR: $error] - $details');
  }
}