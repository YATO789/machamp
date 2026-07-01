// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_create_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MenuCreateState {

 List<MenuExercise> get menuExercises; int? get expandedIndex; AsyncValue<List<Exercise>> get exercises;
/// Create a copy of MenuCreateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuCreateStateCopyWith<MenuCreateState> get copyWith => _$MenuCreateStateCopyWithImpl<MenuCreateState>(this as MenuCreateState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuCreateState&&const DeepCollectionEquality().equals(other.menuExercises, menuExercises)&&(identical(other.expandedIndex, expandedIndex) || other.expandedIndex == expandedIndex)&&(identical(other.exercises, exercises) || other.exercises == exercises));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(menuExercises),expandedIndex,exercises);

@override
String toString() {
  return 'MenuCreateState(menuExercises: $menuExercises, expandedIndex: $expandedIndex, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $MenuCreateStateCopyWith<$Res>  {
  factory $MenuCreateStateCopyWith(MenuCreateState value, $Res Function(MenuCreateState) _then) = _$MenuCreateStateCopyWithImpl;
@useResult
$Res call({
 List<MenuExercise> menuExercises, int? expandedIndex, AsyncValue<List<Exercise>> exercises
});




}
/// @nodoc
class _$MenuCreateStateCopyWithImpl<$Res>
    implements $MenuCreateStateCopyWith<$Res> {
  _$MenuCreateStateCopyWithImpl(this._self, this._then);

  final MenuCreateState _self;
  final $Res Function(MenuCreateState) _then;

/// Create a copy of MenuCreateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? menuExercises = null,Object? expandedIndex = freezed,Object? exercises = null,}) {
  return _then(_self.copyWith(
menuExercises: null == menuExercises ? _self.menuExercises : menuExercises // ignore: cast_nullable_to_non_nullable
as List<MenuExercise>,expandedIndex: freezed == expandedIndex ? _self.expandedIndex : expandedIndex // ignore: cast_nullable_to_non_nullable
as int?,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Exercise>>,
  ));
}

}


/// Adds pattern-matching-related methods to [MenuCreateState].
extension MenuCreateStatePatterns on MenuCreateState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuCreateState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuCreateState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuCreateState value)  $default,){
final _that = this;
switch (_that) {
case _MenuCreateState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuCreateState value)?  $default,){
final _that = this;
switch (_that) {
case _MenuCreateState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MenuExercise> menuExercises,  int? expandedIndex,  AsyncValue<List<Exercise>> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuCreateState() when $default != null:
return $default(_that.menuExercises,_that.expandedIndex,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MenuExercise> menuExercises,  int? expandedIndex,  AsyncValue<List<Exercise>> exercises)  $default,) {final _that = this;
switch (_that) {
case _MenuCreateState():
return $default(_that.menuExercises,_that.expandedIndex,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MenuExercise> menuExercises,  int? expandedIndex,  AsyncValue<List<Exercise>> exercises)?  $default,) {final _that = this;
switch (_that) {
case _MenuCreateState() when $default != null:
return $default(_that.menuExercises,_that.expandedIndex,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc


class _MenuCreateState implements MenuCreateState {
  const _MenuCreateState({final  List<MenuExercise> menuExercises = const [], this.expandedIndex, this.exercises = const AsyncLoading<List<Exercise>>()}): _menuExercises = menuExercises;
  

 final  List<MenuExercise> _menuExercises;
@override@JsonKey() List<MenuExercise> get menuExercises {
  if (_menuExercises is EqualUnmodifiableListView) return _menuExercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_menuExercises);
}

@override final  int? expandedIndex;
@override@JsonKey() final  AsyncValue<List<Exercise>> exercises;

/// Create a copy of MenuCreateState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuCreateStateCopyWith<_MenuCreateState> get copyWith => __$MenuCreateStateCopyWithImpl<_MenuCreateState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuCreateState&&const DeepCollectionEquality().equals(other._menuExercises, _menuExercises)&&(identical(other.expandedIndex, expandedIndex) || other.expandedIndex == expandedIndex)&&(identical(other.exercises, exercises) || other.exercises == exercises));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_menuExercises),expandedIndex,exercises);

@override
String toString() {
  return 'MenuCreateState(menuExercises: $menuExercises, expandedIndex: $expandedIndex, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$MenuCreateStateCopyWith<$Res> implements $MenuCreateStateCopyWith<$Res> {
  factory _$MenuCreateStateCopyWith(_MenuCreateState value, $Res Function(_MenuCreateState) _then) = __$MenuCreateStateCopyWithImpl;
@override @useResult
$Res call({
 List<MenuExercise> menuExercises, int? expandedIndex, AsyncValue<List<Exercise>> exercises
});




}
/// @nodoc
class __$MenuCreateStateCopyWithImpl<$Res>
    implements _$MenuCreateStateCopyWith<$Res> {
  __$MenuCreateStateCopyWithImpl(this._self, this._then);

  final _MenuCreateState _self;
  final $Res Function(_MenuCreateState) _then;

/// Create a copy of MenuCreateState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? menuExercises = null,Object? expandedIndex = freezed,Object? exercises = null,}) {
  return _then(_MenuCreateState(
menuExercises: null == menuExercises ? _self._menuExercises : menuExercises // ignore: cast_nullable_to_non_nullable
as List<MenuExercise>,expandedIndex: freezed == expandedIndex ? _self.expandedIndex : expandedIndex // ignore: cast_nullable_to_non_nullable
as int?,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Exercise>>,
  ));
}


}

// dart format on
