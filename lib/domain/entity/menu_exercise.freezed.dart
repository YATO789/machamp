// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MenuExercise {

 Exercise get exercise; List<ExerciseSet> get sets;
/// Create a copy of MenuExercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuExerciseCopyWith<MenuExercise> get copyWith => _$MenuExerciseCopyWithImpl<MenuExercise>(this as MenuExercise, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuExercise&&(identical(other.exercise, exercise) || other.exercise == exercise)&&const DeepCollectionEquality().equals(other.sets, sets));
}


@override
int get hashCode => Object.hash(runtimeType,exercise,const DeepCollectionEquality().hash(sets));

@override
String toString() {
  return 'MenuExercise(exercise: $exercise, sets: $sets)';
}


}

/// @nodoc
abstract mixin class $MenuExerciseCopyWith<$Res>  {
  factory $MenuExerciseCopyWith(MenuExercise value, $Res Function(MenuExercise) _then) = _$MenuExerciseCopyWithImpl;
@useResult
$Res call({
 Exercise exercise, List<ExerciseSet> sets
});


$ExerciseCopyWith<$Res> get exercise;

}
/// @nodoc
class _$MenuExerciseCopyWithImpl<$Res>
    implements $MenuExerciseCopyWith<$Res> {
  _$MenuExerciseCopyWithImpl(this._self, this._then);

  final MenuExercise _self;
  final $Res Function(MenuExercise) _then;

/// Create a copy of MenuExercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exercise = null,Object? sets = null,}) {
  return _then(_self.copyWith(
exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as Exercise,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<ExerciseSet>,
  ));
}
/// Create a copy of MenuExercise
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExerciseCopyWith<$Res> get exercise {
  
  return $ExerciseCopyWith<$Res>(_self.exercise, (value) {
    return _then(_self.copyWith(exercise: value));
  });
}
}


/// Adds pattern-matching-related methods to [MenuExercise].
extension MenuExercisePatterns on MenuExercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuExercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuExercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuExercise value)  $default,){
final _that = this;
switch (_that) {
case _MenuExercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuExercise value)?  $default,){
final _that = this;
switch (_that) {
case _MenuExercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Exercise exercise,  List<ExerciseSet> sets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuExercise() when $default != null:
return $default(_that.exercise,_that.sets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Exercise exercise,  List<ExerciseSet> sets)  $default,) {final _that = this;
switch (_that) {
case _MenuExercise():
return $default(_that.exercise,_that.sets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Exercise exercise,  List<ExerciseSet> sets)?  $default,) {final _that = this;
switch (_that) {
case _MenuExercise() when $default != null:
return $default(_that.exercise,_that.sets);case _:
  return null;

}
}

}

/// @nodoc


class _MenuExercise implements MenuExercise {
  const _MenuExercise({required this.exercise, required final  List<ExerciseSet> sets}): _sets = sets;
  

@override final  Exercise exercise;
 final  List<ExerciseSet> _sets;
@override List<ExerciseSet> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}


/// Create a copy of MenuExercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuExerciseCopyWith<_MenuExercise> get copyWith => __$MenuExerciseCopyWithImpl<_MenuExercise>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuExercise&&(identical(other.exercise, exercise) || other.exercise == exercise)&&const DeepCollectionEquality().equals(other._sets, _sets));
}


@override
int get hashCode => Object.hash(runtimeType,exercise,const DeepCollectionEquality().hash(_sets));

@override
String toString() {
  return 'MenuExercise(exercise: $exercise, sets: $sets)';
}


}

/// @nodoc
abstract mixin class _$MenuExerciseCopyWith<$Res> implements $MenuExerciseCopyWith<$Res> {
  factory _$MenuExerciseCopyWith(_MenuExercise value, $Res Function(_MenuExercise) _then) = __$MenuExerciseCopyWithImpl;
@override @useResult
$Res call({
 Exercise exercise, List<ExerciseSet> sets
});


@override $ExerciseCopyWith<$Res> get exercise;

}
/// @nodoc
class __$MenuExerciseCopyWithImpl<$Res>
    implements _$MenuExerciseCopyWith<$Res> {
  __$MenuExerciseCopyWithImpl(this._self, this._then);

  final _MenuExercise _self;
  final $Res Function(_MenuExercise) _then;

/// Create a copy of MenuExercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exercise = null,Object? sets = null,}) {
  return _then(_MenuExercise(
exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as Exercise,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<ExerciseSet>,
  ));
}

/// Create a copy of MenuExercise
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExerciseCopyWith<$Res> get exercise {
  
  return $ExerciseCopyWith<$Res>(_self.exercise, (value) {
    return _then(_self.copyWith(exercise: value));
  });
}
}

// dart format on
