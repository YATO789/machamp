import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:machamp/src/domain/entity/exercise.dart';

const _predefinedExercises = <Exercise>[
  Exercise(id: 'squat', name: 'スクワット', bodyPart: '脚', equipment: 'バーベル'),
  Exercise(id: 'leg_press', name: 'レッグプレス', bodyPart: '脚', equipment: 'マシン'),
  Exercise(id: 'leg_curl', name: 'レッグカール', bodyPart: '脚', equipment: 'マシン'),
  Exercise(id: 'lunge', name: 'ランジ', bodyPart: '脚', equipment: '自重'),
  Exercise(id: 'calf_raise', name: 'カーフレイズ', bodyPart: '脚', equipment: '自重'),
  Exercise(id: 'bench_press', name: 'ベンチプレス', bodyPart: '胸', equipment: 'バーベル'),
  Exercise(id: 'db_press', name: 'ダンベルプレス', bodyPart: '胸', equipment: 'ダンベル'),
  Exercise(
    id: 'incline_press',
    name: 'インクラインプレス',
    bodyPart: '胸',
    equipment: 'ダンベル',
  ),
  Exercise(id: 'chest_fly', name: 'チェストフライ', bodyPart: '胸', equipment: 'ケーブル'),
  Exercise(id: 'push_up', name: 'プッシュアップ', bodyPart: '胸', equipment: '自重'),
  Exercise(id: 'pull_up', name: '懸垂', bodyPart: '背中', equipment: '自重'),
  Exercise(id: 'deadlift', name: 'デッドリフト', bodyPart: '背中', equipment: 'バーベル'),
  Exercise(
    id: 'lat_pulldown',
    name: 'ラットプルダウン',
    bodyPart: '背中',
    equipment: 'マシン',
  ),
  Exercise(id: 'seated_row', name: 'シーテッドロウ', bodyPart: '背中', equipment: 'マシン'),
  Exercise(id: 'db_row', name: 'ダンベルロウ', bodyPart: '背中', equipment: 'ダンベル'),
  Exercise(id: 'ohp', name: 'オーバーヘッドプレス', bodyPart: '肩', equipment: 'バーベル'),
  Exercise(
    id: 'lateral_raise',
    name: 'サイドレイズ',
    bodyPart: '肩',
    equipment: 'ダンベル',
  ),
  Exercise(
    id: 'front_raise',
    name: 'フロントレイズ',
    bodyPart: '肩',
    equipment: 'ダンベル',
  ),
  Exercise(id: 'face_pull', name: 'フェイスプル', bodyPart: '肩', equipment: 'ケーブル'),
  Exercise(
    id: 'bicep_curl',
    name: 'バイセップカール',
    bodyPart: '腕',
    equipment: 'ダンベル',
  ),
  Exercise(
    id: 'hammer_curl',
    name: 'ハンマーカール',
    bodyPart: '腕',
    equipment: 'ダンベル',
  ),
  Exercise(
    id: 'tricep_ext',
    name: 'トライセップエクステンション',
    bodyPart: '腕',
    equipment: 'ケーブル',
  ),
  Exercise(
    id: 'tricep_pushdown',
    name: 'トライセッププッシュダウン',
    bodyPart: '腕',
    equipment: 'ケーブル',
  ),
  Exercise(id: 'crunch', name: 'クランチ', bodyPart: '腹筋', equipment: '自重'),
  Exercise(id: 'plank', name: 'プランク', bodyPart: '腹筋', equipment: '自重'),
  Exercise(id: 'leg_raise', name: 'レッグレイズ', bodyPart: '腹筋', equipment: '自重'),
  Exercise(id: 'ab_roller', name: 'アブローラー', bodyPart: '腹筋', equipment: '自重'),
];

class ExercisesNotifier extends Notifier<List<Exercise>> {
  @override
  List<Exercise> build() => _predefinedExercises;

  void addCustomExercise({
    required String name,
    required String bodyPart,
    required String equipment,
  }) {
    final exercise = Exercise(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      bodyPart: bodyPart,
      equipment: equipment,
      isCustom: true,
    );
    state = [...state, exercise];
  }
}

final exercisesProvider = NotifierProvider<ExercisesNotifier, List<Exercise>>(
  ExercisesNotifier.new,
);
