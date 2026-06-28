import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machamp/domain/entity/menu_exercise.dart';

part 'menu.freezed.dart';

@freezed
abstract class Menu with _$Menu {
  const factory Menu({
    required String id,
    required String name,
    required List<MenuExercise> exercises,
  }) = _Menu;
}
