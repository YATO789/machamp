import 'package:machamp/src/domain/entity/exercise.dart';

class ExerciseDto {
  ExerciseDto.fromMap(Map<String, dynamic> map)
    : id = map['id'] as String,
      name = map['name'] as String,
      equipment = (map['equipments'] as Map<String, dynamic>)['name'] as String,
      bodyParts = (map['exercise_body_parts'] as List<dynamic>)
          .map(
            (e) =>
                ((e as Map<String, dynamic>)['body_parts']
                        as Map<String, dynamic>)['name']
                    as String,
          )
          .toList(),
      userId = map['user_id'] as String?;

  final String id;
  final String name;
  final String equipment;
  final List<String> bodyParts;
  final String? userId;

  Exercise toDomain() => Exercise(
    id: id,
    name: name,
    bodyParts: bodyParts,
    equipment: equipment,
    isCustom: userId != null,
  );
}
