import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';

@freezed
abstract class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    required String name,
    required List<String> bodyParts,
    required String equipment,
    @Default(false) bool isCustom,
  }) = _Exercise;
}
