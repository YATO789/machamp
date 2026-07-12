import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_part.freezed.dart';

@freezed
abstract class BodyPart with _$BodyPart {
  const factory BodyPart({
    required String id,
    required String name,
    required int sortOrder,
  }) = _BodyPart;
}

extension BodyPartX on BodyPart {
  String get displayName => const {
        'legs': '脚',
        'chest': '胸',
        'back': '背中',
        'shoulders': '肩',
        'arms': '腕',
        'abs': '腹筋',
      }[name] ??
      name;
}
