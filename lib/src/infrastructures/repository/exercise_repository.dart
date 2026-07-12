import 'package:machamp/src/domain/entity/body_part.dart';
import 'package:machamp/src/domain/entity/equipment.dart';
import 'package:machamp/src/domain/entity/exercise.dart';
import 'package:machamp/src/infrastructures/datasource/exercise_datasource.dart';
import 'package:machamp/src/infrastructures/model/body_part_dto.dart';
import 'package:machamp/src/infrastructures/model/equipment_dto.dart';
import 'package:machamp/src/infrastructures/model/exercise_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_repository.g.dart';

@riverpod
ExerciseRepository exerciseRepository(Ref ref) {
  return ExerciseRepository(ref.watch(exerciseDataSourceProvider));
}

class ExerciseRepository {
  ExerciseRepository(this._dataSource);
  final ExerciseDataSource _dataSource;

  Future<List<Exercise>> fetchExercises(String userId) async {
    final data = await _dataSource.fetchExercises(userId);
    return data.map((e) => ExerciseDto.fromMap(e).toDomain()).toList();
  }

  Future<List<BodyPart>> fetchBodyParts() async {
    final data = await _dataSource.fetchBodyParts();
    return data.map((e) => BodyPartDto.fromMap(e).toDomain()).toList();
  }

  Future<List<Equipment>> fetchEquipments() async {
    final data = await _dataSource.fetchEquipments();
    return data.map((e) => EquipmentDto.fromMap(e).toDomain()).toList();
  }

  Future<Exercise> createExercise({
    required String userId,
    required String name,
    required String equipmentId,
    required List<String> bodyPartIds,
  }) async {
    final data = await _dataSource.createExercise(
      userId: userId,
      name: name,
      equipmentId: equipmentId,
      bodyPartIds: bodyPartIds,
    );
    return ExerciseDto.fromMap(data).toDomain();
  }
}
