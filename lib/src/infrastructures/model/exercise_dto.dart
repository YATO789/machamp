import 'package:machamp/src/domain/entity/exercise.dart';

class ExerciseDto {
  ExerciseDto.fromMap(Map<String, dynamic> map)
    : id = (map['id']) as String,
      name = (map['name']) as String,
      bodyPart = (map['body_part']) as String,
      equipment = (map['equipment']) as String,
      userId = map['user_id'] as String?;
  final String id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String? userId;
}

extension ExerciseDtoMapper on ExerciseDto {
  Exercise toDomain() {
    return Exercise(
      id: id,
      name: name,
      bodyPart: bodyPart,
      equipment: equipment,
      isCustom: userId != null,
    );
  }
}
