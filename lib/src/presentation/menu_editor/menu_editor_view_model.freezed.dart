// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_editor_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MenuEditorState {

 String get originalName; List<MenuExercise> get menuExercises; Set<int> get expandedIndices; bool get isExercisesDirty; bool get isSaving; bool get isDeleting;
/// Create a copy of MenuEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuEditorStateCopyWith<MenuEditorState> get copyWith => _$MenuEditorStateCopyWithImpl<MenuEditorState>(this as MenuEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuEditorState&&(identical(other.originalName, originalName) || other.originalName == originalName)&&const DeepCollectionEquality().equals(other.menuExercises, menuExercises)&&const DeepCollectionEquality().equals(other.expandedIndices, expandedIndices)&&(identical(other.isExercisesDirty, isExercisesDirty) || other.isExercisesDirty == isExercisesDirty)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isDeleting, isDeleting) || other.isDeleting == isDeleting));
}


@override
int get hashCode => Object.hash(runtimeType,originalName,const DeepCollectionEquality().hash(menuExercises),const DeepCollectionEquality().hash(expandedIndices),isExercisesDirty,isSaving,isDeleting);

@override
String toString() {
  return 'MenuEditorState(originalName: $originalName, menuExercises: $menuExercises, expandedIndices: $expandedIndices, isExercisesDirty: $isExercisesDirty, isSaving: $isSaving, isDeleting: $isDeleting)';
}


}

/// @nodoc
abstract mixin class $MenuEditorStateCopyWith<$Res>  {
  factory $MenuEditorStateCopyWith(MenuEditorState value, $Res Function(MenuEditorState) _then) = _$MenuEditorStateCopyWithImpl;
@useResult
$Res call({
 String originalName, List<MenuExercise> menuExercises, Set<int> expandedIndices, bool isExercisesDirty, bool isSaving, bool isDeleting
});




}
/// @nodoc
class _$MenuEditorStateCopyWithImpl<$Res>
    implements $MenuEditorStateCopyWith<$Res> {
  _$MenuEditorStateCopyWithImpl(this._self, this._then);

  final MenuEditorState _self;
  final $Res Function(MenuEditorState) _then;

/// Create a copy of MenuEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originalName = null,Object? menuExercises = null,Object? expandedIndices = null,Object? isExercisesDirty = null,Object? isSaving = null,Object? isDeleting = null,}) {
  return _then(_self.copyWith(
originalName: null == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String,menuExercises: null == menuExercises ? _self.menuExercises : menuExercises // ignore: cast_nullable_to_non_nullable
as List<MenuExercise>,expandedIndices: null == expandedIndices ? _self.expandedIndices : expandedIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,isExercisesDirty: null == isExercisesDirty ? _self.isExercisesDirty : isExercisesDirty // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isDeleting: null == isDeleting ? _self.isDeleting : isDeleting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MenuEditorState].
extension MenuEditorStatePatterns on MenuEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MenuEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MenuEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MenuEditorState value)  $default,){
final _that = this;
switch (_that) {
case _MenuEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MenuEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _MenuEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String originalName,  List<MenuExercise> menuExercises,  Set<int> expandedIndices,  bool isExercisesDirty,  bool isSaving,  bool isDeleting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MenuEditorState() when $default != null:
return $default(_that.originalName,_that.menuExercises,_that.expandedIndices,_that.isExercisesDirty,_that.isSaving,_that.isDeleting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String originalName,  List<MenuExercise> menuExercises,  Set<int> expandedIndices,  bool isExercisesDirty,  bool isSaving,  bool isDeleting)  $default,) {final _that = this;
switch (_that) {
case _MenuEditorState():
return $default(_that.originalName,_that.menuExercises,_that.expandedIndices,_that.isExercisesDirty,_that.isSaving,_that.isDeleting);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String originalName,  List<MenuExercise> menuExercises,  Set<int> expandedIndices,  bool isExercisesDirty,  bool isSaving,  bool isDeleting)?  $default,) {final _that = this;
switch (_that) {
case _MenuEditorState() when $default != null:
return $default(_that.originalName,_that.menuExercises,_that.expandedIndices,_that.isExercisesDirty,_that.isSaving,_that.isDeleting);case _:
  return null;

}
}

}

/// @nodoc


class _MenuEditorState implements MenuEditorState {
  const _MenuEditorState({this.originalName = '', final  List<MenuExercise> menuExercises = const [], final  Set<int> expandedIndices = const <int>{}, this.isExercisesDirty = false, this.isSaving = false, this.isDeleting = false}): _menuExercises = menuExercises,_expandedIndices = expandedIndices;
  

@override@JsonKey() final  String originalName;
 final  List<MenuExercise> _menuExercises;
@override@JsonKey() List<MenuExercise> get menuExercises {
  if (_menuExercises is EqualUnmodifiableListView) return _menuExercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_menuExercises);
}

 final  Set<int> _expandedIndices;
@override@JsonKey() Set<int> get expandedIndices {
  if (_expandedIndices is EqualUnmodifiableSetView) return _expandedIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_expandedIndices);
}

@override@JsonKey() final  bool isExercisesDirty;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isDeleting;

/// Create a copy of MenuEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MenuEditorStateCopyWith<_MenuEditorState> get copyWith => __$MenuEditorStateCopyWithImpl<_MenuEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MenuEditorState&&(identical(other.originalName, originalName) || other.originalName == originalName)&&const DeepCollectionEquality().equals(other._menuExercises, _menuExercises)&&const DeepCollectionEquality().equals(other._expandedIndices, _expandedIndices)&&(identical(other.isExercisesDirty, isExercisesDirty) || other.isExercisesDirty == isExercisesDirty)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isDeleting, isDeleting) || other.isDeleting == isDeleting));
}


@override
int get hashCode => Object.hash(runtimeType,originalName,const DeepCollectionEquality().hash(_menuExercises),const DeepCollectionEquality().hash(_expandedIndices),isExercisesDirty,isSaving,isDeleting);

@override
String toString() {
  return 'MenuEditorState(originalName: $originalName, menuExercises: $menuExercises, expandedIndices: $expandedIndices, isExercisesDirty: $isExercisesDirty, isSaving: $isSaving, isDeleting: $isDeleting)';
}


}

/// @nodoc
abstract mixin class _$MenuEditorStateCopyWith<$Res> implements $MenuEditorStateCopyWith<$Res> {
  factory _$MenuEditorStateCopyWith(_MenuEditorState value, $Res Function(_MenuEditorState) _then) = __$MenuEditorStateCopyWithImpl;
@override @useResult
$Res call({
 String originalName, List<MenuExercise> menuExercises, Set<int> expandedIndices, bool isExercisesDirty, bool isSaving, bool isDeleting
});




}
/// @nodoc
class __$MenuEditorStateCopyWithImpl<$Res>
    implements _$MenuEditorStateCopyWith<$Res> {
  __$MenuEditorStateCopyWithImpl(this._self, this._then);

  final _MenuEditorState _self;
  final $Res Function(_MenuEditorState) _then;

/// Create a copy of MenuEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalName = null,Object? menuExercises = null,Object? expandedIndices = null,Object? isExercisesDirty = null,Object? isSaving = null,Object? isDeleting = null,}) {
  return _then(_MenuEditorState(
originalName: null == originalName ? _self.originalName : originalName // ignore: cast_nullable_to_non_nullable
as String,menuExercises: null == menuExercises ? _self._menuExercises : menuExercises // ignore: cast_nullable_to_non_nullable
as List<MenuExercise>,expandedIndices: null == expandedIndices ? _self._expandedIndices : expandedIndices // ignore: cast_nullable_to_non_nullable
as Set<int>,isExercisesDirty: null == isExercisesDirty ? _self.isExercisesDirty : isExercisesDirty // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isDeleting: null == isDeleting ? _self.isDeleting : isDeleting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
