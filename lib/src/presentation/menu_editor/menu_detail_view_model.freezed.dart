// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_detail_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MenuDetailState {

 String get originalName; List<MenuExercise> get menuExercises; int? get expandedIndex; bool get isExercisesDirty;
/// Create a copy of MenuDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuDetailStateCopyWith<MenuDetailState> get copyWith => _$MenuDetailStateCopyWithImpl<MenuDetailState>(this as MenuDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuDetailState&&(identical(other.originalName, originalName) || other.originalName == originalName)&&const DeepCollectionEquality().equals(other.menuExercises, menuExercises)&&(identical(other.expandedIndex, expandedIndex) || other.expandedIndex == expandedIndex)&&(identical(other.isExercisesDirty, isExercisesDirty) || other.isExercisesDirty == isExercisesDirty));
}


@override
int get hashCode => Object.hash(runtimeType,originalName,const DeepCollectionEquality().hash(menuExercises),expandedIndex,isExercisesDirty);

@override
String toString() {
  return 'MenuDetailState(originalName: $originalName, menuExercises: $menuExercises, expandedIndex: $expandedIndex, isExercisesDirty: $isExercisesDirty)';
}


}

/// @nodoc
abstract mixin class $MenuDetailStateCopyWith<$Res>  {
  factory $MenuDetailStateCopyWith(MenuDetailState value, $Res Function(MenuDetailState) _then) = _$MenuDetailStateCopyWithImpl;
@useResult
$Res call({
 String originalName, List<MenuExercise> menuExercises, int? expandedIndex, bool isExercisesDirty
});




}
/// @nodoc
class _$MenuDetailStateCopyWithImpl<$Res>
    implements $MenuDetailStateCopyWith<$Res> {
  _$MenuDetailStateCopyWithImpl(this._self, this._then);

  final MenuDetailState _self;
  final $Res Function(MenuDetailState) _then;

/// Create a copy of MenuDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originalName = null,Object? menuExercises = null,Object? expandedIndex = freezed,Object? isExercisesDirty = null,}) {
  return _then(_self.copyWith(
originalName: null == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String,menuExercises: null == menuExercises ? _self.menuExercises : menuExercises // ignore: cast_nullable_to_non_nullable
as List<MenuExercise>,expandedIndex: freezed == expandedIndex ? _self.expandedIndex : expandedIndex // ignore: cast_nullable_to_non_nullable
as int?,isExercisesDirty: null == isExercisesDirty ? _self.isExercisesDirty : isExercisesDirty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MenuDetailState].
extension MenuDetailStatePatterns on MenuDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuDetailState value)  $default,){
final _that = this;
switch (_that) {
case _MenuDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _MenuDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String originalName,  List<MenuExercise> menuExercises,  int? expandedIndex,  bool isExercisesDirty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuDetailState() when $default != null:
return $default(_that.originalName,_that.menuExercises,_that.expandedIndex,_that.isExercisesDirty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String originalName,  List<MenuExercise> menuExercises,  int? expandedIndex,  bool isExercisesDirty)  $default,) {final _that = this;
switch (_that) {
case _MenuDetailState():
return $default(_that.originalName,_that.menuExercises,_that.expandedIndex,_that.isExercisesDirty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String originalName,  List<MenuExercise> menuExercises,  int? expandedIndex,  bool isExercisesDirty)?  $default,) {final _that = this;
switch (_that) {
case _MenuDetailState() when $default != null:
return $default(_that.originalName,_that.menuExercises,_that.expandedIndex,_that.isExercisesDirty);case _:
  return null;

}
}

}

/// @nodoc


class _MenuDetailState implements MenuDetailState {
  const _MenuDetailState({required this.originalName, required final  List<MenuExercise> menuExercises, this.expandedIndex, this.isExercisesDirty = false}): _menuExercises = menuExercises;
  

@override final  String originalName;
 final  List<MenuExercise> _menuExercises;
@override List<MenuExercise> get menuExercises {
  if (_menuExercises is EqualUnmodifiableListView) return _menuExercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_menuExercises);
}

@override final  int? expandedIndex;
@override@JsonKey() final  bool isExercisesDirty;

/// Create a copy of MenuDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuDetailStateCopyWith<_MenuDetailState> get copyWith => __$MenuDetailStateCopyWithImpl<_MenuDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuDetailState&&(identical(other.originalName, originalName) || other.originalName == originalName)&&const DeepCollectionEquality().equals(other._menuExercises, _menuExercises)&&(identical(other.expandedIndex, expandedIndex) || other.expandedIndex == expandedIndex)&&(identical(other.isExercisesDirty, isExercisesDirty) || other.isExercisesDirty == isExercisesDirty));
}


@override
int get hashCode => Object.hash(runtimeType,originalName,const DeepCollectionEquality().hash(_menuExercises),expandedIndex,isExercisesDirty);

@override
String toString() {
  return 'MenuDetailState(originalName: $originalName, menuExercises: $menuExercises, expandedIndex: $expandedIndex, isExercisesDirty: $isExercisesDirty)';
}


}

/// @nodoc
abstract mixin class _$MenuDetailStateCopyWith<$Res> implements $MenuDetailStateCopyWith<$Res> {
  factory _$MenuDetailStateCopyWith(_MenuDetailState value, $Res Function(_MenuDetailState) _then) = __$MenuDetailStateCopyWithImpl;
@override @useResult
$Res call({
 String originalName, List<MenuExercise> menuExercises, int? expandedIndex, bool isExercisesDirty
});




}
/// @nodoc
class __$MenuDetailStateCopyWithImpl<$Res>
    implements _$MenuDetailStateCopyWith<$Res> {
  __$MenuDetailStateCopyWithImpl(this._self, this._then);

  final _MenuDetailState _self;
  final $Res Function(_MenuDetailState) _then;

/// Create a copy of MenuDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalName = null,Object? menuExercises = null,Object? expandedIndex = freezed,Object? isExercisesDirty = null,}) {
  return _then(_MenuDetailState(
originalName: null == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String,menuExercises: null == menuExercises ? _self._menuExercises : menuExercises // ignore: cast_nullable_to_non_nullable
as List<MenuExercise>,expandedIndex: freezed == expandedIndex ? _self.expandedIndex : expandedIndex // ignore: cast_nullable_to_non_nullable
as int?,isExercisesDirty: null == isExercisesDirty ? _self.isExercisesDirty : isExercisesDirty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
