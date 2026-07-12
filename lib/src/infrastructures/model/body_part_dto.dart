import 'package:machamp/src/domain/entity/body_part.dart';

class BodyPartDto {
  BodyPartDto.fromMap(Map<String, dynamic> map)
    : id = map['id'] as String,
      name = map['name'] as String,
      sortOrder = map['sort_order'] as int;

  final String id;
  final String name;
  final int sortOrder;

  BodyPart toDomain() => BodyPart(id: id, name: name, sortOrder: sortOrder);
}
