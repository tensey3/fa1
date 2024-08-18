class Constants {
  // カラオケスキルレベルの選択肢
  // プロフィール関連のラベル
  static const String bioLabel = '自己紹介';
  static const String karaokeSkillLabel = 'カラオケスキル';
  static const String karaokeFrequencyLabel = 'カラオケの頻度';
  static const String karaokePurposeLabel = 'カラオケの目的';

  // カラオケスキルレベルの選択肢
  static const List<String> karaokeSkillLevels = ['初心者', '中級者', '上級者'];

  // カラオケの頻度の選択肢
  static const List<String> karaokeFrequencies = ['週に1回', '月に1回', 'たまに'];

  // カラオケの目的の選択肢
  static const List<String> karaokePurposes = ['楽しむため', '練習のため', '友達と'];

  static const List<String> genres = [
    'ポップ',
    'ロック',
    'ジャズ',
    'ヒップホップ',
    'クラシック',
    '演歌',
    'アニメ',
    'VOCALOID',
  ];

  // DAM機種の選択肢
  static const List<String> damMachines = [
    'LIVE DAM AiR（DAM-XG8000R）',
    'LIVE DAM Ai（DAM-XG8000）',
    'Cyber DAM +（DAM-G100W）',
  ];

  // JOYSOUND機種の選択肢
  static const List<String> joySoundMachines = [
    'JOYSOUND X1',
    'JOYSOUND MAX GO',
    'JOYSOUND 響Ⅱ',
  ];

  // 機種カテゴリーの選択肢
  static const List<String> machineCategories = [
    'DAM',
    'JOYSOUND',
    '両方',
    'こだわりはない／どちらでもいい',
  ];
}