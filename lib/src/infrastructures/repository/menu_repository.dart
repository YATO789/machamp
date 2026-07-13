import 'package:machamp/src/domain/entity/menu.dart';
import 'package:machamp/src/domain/entity/menu_exercise.dart';
import 'package:machamp/src/infrastructures/datasource/menu_datasource.dart';
import 'package:machamp/src/infrastructures/model/menu_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_repository.g.dart';

@riverpod
MenuRepository menuRepository(Ref ref) {
  return MenuRepository(ref.watch(menuDataSourceProvider));
}

class MenuRepository {
  MenuRepository(this._dataSource);
  final MenuDataSource _dataSource;

  Future<List<Menu>> fetchMenus() async {
    final data = await _dataSource.fetchMenus();
    return data.map((e) => MenuDto.fromMap(e).toDomain()).toList();
  }

  Future<Menu> createMenu({
    required String name,
    required List<MenuExercise> exercises,
  }) async {
    final data = await _dataSource.createMenu(
      name: name,
      exercisesJson: _toJson(exercises),
    );
    return MenuDto.fromMap(data).toDomain();
  }

  Future<Menu> updateMenu({
    required String id,
    required String name,
    required List<MenuExercise> exercises,
  }) async {
    final data = await _dataSource.updateMenu(
      id: id,
      name: name,
      exercisesJson: _toJson(exercises),
    );
    return MenuDto.fromMap(data).toDomain();
  }

  Future<void> deleteMenu(String id) async {
    await _dataSource.deleteMenu(id);
  }

  List<Map<String, dynamic>> _toJson(List<MenuExercise> exercises) {
    return exercises
        .map(
          (me) => {
            'exercise_id': me.exercise.id,
            'sets': me.sets
                .map((s) => {
                  'reps': s.reps,
                  'weight': s.weight,
                  'interval_seconds': s.intervalSeconds,
                })
                .toList(),
          },
        )
        .toList();
  }
}
