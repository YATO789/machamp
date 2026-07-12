// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_selection_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExerciseSelectionState implements DiagnosticableTreeMixin {

 AsyncValue<List<Exercise>> get exercises; List<Exercise> get addedExercises; List<String> get selectedIds; List<BodyPart> get bodyParts; List<Equipment> get equipments;
/// Create a copy of ExerciseSelectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseSelectionStateCopyWith<ExerciseSelectionState> get copyWith => _$ExerciseSelectionStateCopyWithImpl<ExerciseSelectionState>(this as ExerciseSelectionState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExerciseSelectionState'))
    ..add(DiagnosticsProperty('exercises', exercises))..add(DiagnosticsProperty('addedExercises', addedExercises))..add(DiagnosticsProperty('selectedIds', selectedIds))..add(DiagnosticsProperty('bodyParts', bodyParts))..add(DiagnosticsProperty('equipments', equipments));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseSelectionState&&(identical(other.exercises, exercises) || other.exercises == exercises)&&const DeepCollectionEquality().equals(other.addedExercises, addedExercises)&&const DeepCollectionEquality().equals(other.selectedIds, selectedIds)&&const DeepCollectionEquality().equals(other.bodyParts, bodyParts)&&const DeepCollectionEquality().equals(other.equipments, equipments));
}


@override
int get hashCode => Object.hash(runtimeType,exercises,const DeepCollectionEquality().hash(addedExercises),const DeepCollectionEquality().hash(selectedIds),const DeepCollectionEquality().hash(bodyParts),const DeepCollectionEquality().hash(equipments));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExerciseSelectionState(exercises: $exercises, addedExercises: $addedExercises, selectedIds: $selectedIds, bodyParts: $bodyParts, equipments: $equipments)';
}


}

/// @nodoc
abstract mixin class $ExerciseSelectionStateCopyWith<$Res>  {
  factory $ExerciseSelectionStateCopyWith(ExerciseSelectionState value, $Res Function(ExerciseSelectionState) _then) = _$ExerciseSelectionStateCopyWithImpl;
@useResult
$Res call({
 AsyncValue<List<Exercise>> exercises, List<Exercise> addedExercises, List<String> selectedIds, List<BodyPart> bodyParts, List<Equipment> equipments
});




}
/// @nodoc
class _$ExerciseSelectionStateCopyWithImpl<$Res>
    implements $ExerciseSelectionStateCopyWith<$Res> {
  _$ExerciseSelectionStateCopyWithImpl(this._self, this._then);

  final ExerciseSelectionState _self;
  final $Res Function(ExerciseSelectionState) _then;

/// Create a copy of ExerciseSelectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exercises = null,Object? addedExercises = null,Object? selectedIds = null,Object? bodyParts = null,Object? equipments = null,}) {
  return _then(_self.copyWith(
exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Exercise>>,addedExercises: null == addedExercises ? _self.addedExercises : addedExercises // ignore: cast_nullable_to_non_nullable
as List<Exercise>,selectedIds: null == selectedIds ? _self.selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as List<String>,bodyParts: null == bodyParts ? _self.bodyParts : bodyParts // ignore: cast_nullable_to_non_nullable
as List<BodyPart>,equipments: null == equipments ? _self.equipments : equipments // ignore: cast_nullable_to_non_nullable
as List<Equipment>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseSelectionState].
extension ExerciseSelectionStatePatterns on ExerciseSelectionState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseSelectionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseSelectionState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseSelectionState value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseSelectionState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseSelectionState value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseSelectionState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AsyncValue<List<Exercise>> exercises,  List<Exercise> addedExercises,  List<String> selectedIds,  List<BodyPart> bodyParts,  List<Equipment> equipments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseSelectionState() when $default != null:
return $default(_that.exercises,_that.addedExercises,_that.selectedIds,_that.bodyParts,_that.equipments);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AsyncValue<List<Exercise>> exercises,  List<Exercise> addedExercises,  List<String> selectedIds,  List<BodyPart> bodyParts,  List<Equipment> equipments)  $default,) {final _that = this;
switch (_that) {
case _ExerciseSelectionState():
return $default(_that.exercises,_that.addedExercises,_that.selectedIds,_that.bodyParts,_that.equipments);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AsyncValue<List<Exercise>> exercises,  List<Exercise> addedExercises,  List<String> selectedIds,  List<BodyPart> bodyParts,  List<Equipment> equipments)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseSelectionState() when $default != null:
return $default(_that.exercises,_that.addedExercises,_that.selectedIds,_that.bodyParts,_that.equipments);case _:
  return null;

}
}

}

/// @nodoc


class _ExerciseSelectionState with DiagnosticableTreeMixin implements ExerciseSelectionState {
  const _ExerciseSelectionState({this.exercises = const AsyncLoading<List<Exercise>>(), final  List<Exercise> addedExercises = const [], final  List<String> selectedIds = const [], final  List<BodyPart> bodyParts = const [], final  List<Equipment> equipments = const []}): _addedExercises = addedExercises,_selectedIds = selectedIds,_bodyParts = bodyParts,_equipments = equipments;
  

@override@JsonKey() final  AsyncValue<List<Exercise>> exercises;
 final  List<Exercise> _addedExercises;
@override@JsonKey() List<Exercise> get addedExercises {
  if (_addedExercises is EqualUnmodifiableListView) return _addedExercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addedExercises);
}

 final  List<String> _selectedIds;
@override@JsonKey() List<String> get selectedIds {
  if (_selectedIds is EqualUnmodifiableListView) return _selectedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedIds);
}

 final  List<BodyPart> _bodyParts;
@override@JsonKey() List<BodyPart> get bodyParts {
  if (_bodyParts is EqualUnmodifiableListView) return _bodyParts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bodyParts);
}

 final  List<Equipment> _equipments;
@override@JsonKey() List<Equipment> get equipments {
  if (_equipments is EqualUnmodifiableListView) return _equipments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipments);
}


/// Create a copy of ExerciseSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseSelectionStateCopyWith<_ExerciseSelectionState> get copyWith => __$ExerciseSelectionStateCopyWithImpl<_ExerciseSelectionState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExerciseSelectionState'))
    ..add(DiagnosticsProperty('exercises', exercises))..add(DiagnosticsProperty('addedExercises', addedExercises))..add(DiagnosticsProperty('selectedIds', selectedIds))..add(DiagnosticsProperty('bodyParts', bodyParts))..add(DiagnosticsProperty('equipments', equipments));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseSelectionState&&(identical(other.exercises, exercises) || other.exercises == exercises)&&const DeepCollectionEquality().equals(other._addedExercises, _addedExercises)&&const DeepCollectionEquality().equals(other._selectedIds, _selectedIds)&&const DeepCollectionEquality().equals(other._bodyParts, _bodyParts)&&const DeepCollectionEquality().equals(other._equipments, _equipments));
}


@override
int get hashCode => Object.hash(runtimeType,exercises,const DeepCollectionEquality().hash(_addedExercises),const DeepCollectionEquality().hash(_selectedIds),const DeepCollectionEquality().hash(_bodyParts),const DeepCollectionEquality().hash(_equipments));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExerciseSelectionState(exercises: $exercises, addedExercises: $addedExercises, selectedIds: $selectedIds, bodyParts: $bodyParts, equipments: $equipments)';
}


}

/// @nodoc
abstract mixin class _$ExerciseSelectionStateCopyWith<$Res> implements $ExerciseSelectionStateCopyWith<$Res> {
  factory _$ExerciseSelectionStateCopyWith(_ExerciseSelectionState value, $Res Function(_ExerciseSelectionState) _then) = __$ExerciseSelectionStateCopyWithImpl;
@override @useResult
$Res call({
 AsyncValue<List<Exercise>> exercises, List<Exercise> addedExercises, List<String> selectedIds, List<BodyPart> bodyParts, List<Equipment> equipments
});




}
/// @nodoc
class __$ExerciseSelectionStateCopyWithImpl<$Res>
    implements _$ExerciseSelectionStateCopyWith<$Res> {
  __$ExerciseSelectionStateCopyWithImpl(this._self, this._then);

  final _ExerciseSelectionState _self;
  final $Res Function(_ExerciseSelectionState) _then;

/// Create a copy of ExerciseSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exercises = null,Object? addedExercises = null,Object? selectedIds = null,Object? bodyParts = null,Object? equipments = null,}) {
  return _then(_ExerciseSelectionState(
exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Exercise>>,addedExercises: null == addedExercises ? _self._addedExercises : addedExercises // ignore: cast_nullable_to_non_nullable
as List<Exercise>,selectedIds: null == selectedIds ? _self._selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as List<String>,bodyParts: null == bodyParts ? _self._bodyParts : bodyParts // ignore: cast_nullable_to_non_nullable
as List<BodyPart>,equipments: null == equipments ? _self._equipments : equipments // ignore: cast_nullable_to_non_nullable
as List<Equipment>,
  ));
}


}

// dart format on
