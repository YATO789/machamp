import 'package:machamp/src/domain/entity/equipment.dart';

class EquipmentDto {
  EquipmentDto.fromMap(Map<String, dynamic> map)
    : id = map['id'] as String,
      name = map['name'] as String,
      sortOrder = map['sort_order'] as int;

  final String id;
  final String name;
  final int sortOrder;

  Equipment toDomain() => Equipment(id: id, name: name, sortOrder: sortOrder);
}
