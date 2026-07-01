import 'package:machamp/src/domain/entity/exercise.dart';
import 'package:machamp/src/infrastructures/datasource/exercise_datasource.dart';
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

  Future<Exercise> createExercise({
    required String userId,
    required String name,
    required String bodyPart,
    required String equipment,
  }) async {
    final data = await _dataSource.createExercise(
      userId: userId,
      name: name,
      bodyPart: bodyPart,
      equipment: equipment,
    );
    return ExerciseDto.fromMap(data).toDomain();
  }
}
