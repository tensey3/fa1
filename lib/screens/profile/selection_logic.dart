import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpodをインポート
import '../../providers/user_profile_provider.dart';

class SelectionLogic {
  final WidgetRef ref; // BuildContextの代わりにWidgetRefを使用

  SelectionLogic(this.ref);

  // ジャンルのトグル処理
  void toggleGenre(String genre) {
    ref.read(userProfileProvider.notifier).toggleGenre(genre); // refを使用
    _logAction('Genre toggled', genre);
  }

  // 年代の保存処理
  void saveDecades(List<RangeValues> selectedDecadesRanges) {
    ref.read(userProfileProvider.notifier).setSelectedDecadesRanges(selectedDecadesRanges); // refを使用
    _logAction('Decades saved', selectedDecadesRanges.toString());
  }

  // 年代範囲の追加処理
  void addDecadeRange() {
    ref.read(userProfileProvider.notifier).addDecadeRange(const RangeValues(1940, 2024)); // refを使用
    _logAction('Decade range added', '1940 - 2024');
  }

  // 年代範囲の更新処理
  void updateDecadeRange(int index, RangeValues values) {
    final userProfile = ref.read(userProfileProvider); // stateを取得
    if (index >= 0 && index < userProfile.selectedDecadesRanges.length) {
      ref.read(userProfileProvider.notifier).updateDecadeRange(index, values);
      _logAction('Decade range updated', '$index: ${values.start} - ${values.end}');
    } else {
      _logError('Invalid index for updating decade range', index.toString());
    }
  }

  // 年代範囲の削除処理
  void removeDecadeRange(int index) {
    final userProfile = ref.read(userProfileProvider); // stateを取得
    if (index >= 0 && index < userProfile.selectedDecadesRanges.length) {
      ref.read(userProfileProvider.notifier).removeDecadeRange(index);
      _logAction('Decade range removed', index.toString());
    } else {
      _logError('Invalid index for removing decade range', index.toString());
    }
  }

  // よく歌う曲の保存処理
  void saveFavoriteSongs(List<String> favoriteSongs) {
    ref.read(userProfileProvider.notifier).setFavoriteSongs(favoriteSongs); // refを使用
    _logAction('Favorite songs saved', favoriteSongs.join(', '));
  }

  // DAM機種の選択処理
  void setSelectedDamMachine(String value) {
    ref.read(userProfileProvider.notifier).setSelectedDamMachine(value); // refを使用
    _logAction('Selected DAM machine', value);
  }

  // JOYSOUND機種の選択処理
  void setSelectedJoySoundMachine(String value) {
    ref.read(userProfileProvider.notifier).setSelectedJoySoundMachine(value); // refを使用
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