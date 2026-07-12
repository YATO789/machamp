import 'package:freezed_annotation/freezed_annotation.dart';

part 'equipment.freezed.dart';

@freezed
abstract class Equipment with _$Equipment {
  const factory Equipment({
    required String id,
    required String name,
    required int sortOrder,
  }) = _Equipment;
}

extension EquipmentX on Equipment {
  String get displayName =>
      const {
        'barbell': 'バーベル',
        'dumbbell': 'ダンベル',
        'machine': 'マシン',
        'bodyweight': '自重',
        'cable': 'ケーブル',
      }[name] ??
      name;
}
