// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_creation_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExerciseCreationState implements DiagnosticableTreeMixin {

 bool get isLoading; AsyncValue<List<BodyPart>> get bodyParts; AsyncValue<List<Equipment>> get equipments;
/// Create a copy of ExerciseCreationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseCreationStateCopyWith<ExerciseCreationState> get copyWith => _$ExerciseCreationStateCopyWithImpl<ExerciseCreationState>(this as ExerciseCreationState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExerciseCreationState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('bodyParts', bodyParts))..add(DiagnosticsProperty('equipments', equipments));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseCreationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.bodyParts, bodyParts) || other.bodyParts == bodyParts)&&(identical(other.equipments, equipments) || other.equipments == equipments));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,bodyParts,equipments);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExerciseCreationState(isLoading: $isLoading, bodyParts: $bodyParts, equipments: $equipments)';
}


}

/// @nodoc
abstract mixin class $ExerciseCreationStateCopyWith<$Res>  {
  factory $ExerciseCreationStateCopyWith(ExerciseCreationState value, $Res Function(ExerciseCreationState) _then) = _$ExerciseCreationStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, AsyncValue<List<BodyPart>> bodyParts, AsyncValue<List<Equipment>> equipments
});




}
/// @nodoc
class _$ExerciseCreationStateCopyWithImpl<$Res>
    implements $ExerciseCreationStateCopyWith<$Res> {
  _$ExerciseCreationStateCopyWithImpl(this._self, this._then);

  final ExerciseCreationState _self;
  final $Res Function(ExerciseCreationState) _then;

/// Create a copy of ExerciseCreationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? bodyParts = null,Object? equipments = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,bodyParts: null == bodyParts ? _self.bodyParts : bodyParts // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<BodyPart>>,equipments: null == equipments ? _self.equipments : equipments // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Equipment>>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseCreationState].
extension ExerciseCreationStatePatterns on ExerciseCreationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseCreationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseCreationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseCreationState value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseCreationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseCreationState value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseCreationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  AsyncValue<List<BodyPart>> bodyParts,  AsyncValue<List<Equipment>> equipments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseCreationState() when $default != null:
return $default(_that.isLoading,_that.bodyParts,_that.equipments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  AsyncValue<List<BodyPart>> bodyParts,  AsyncValue<List<Equipment>> equipments)  $default,) {final _that = this;
switch (_that) {
case _ExerciseCreationState():
return $default(_that.isLoading,_that.bodyParts,_that.equipments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  AsyncValue<List<BodyPart>> bodyParts,  AsyncValue<List<Equipment>> equipments)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseCreationState() when $default != null:
return $default(_that.isLoading,_that.bodyParts,_that.equipments);case _:
  return null;

}
}

}

/// @nodoc


class _ExerciseCreationState with DiagnosticableTreeMixin implements ExerciseCreationState {
  const _ExerciseCreationState({this.isLoading = false, this.bodyParts = const AsyncLoading<List<BodyPart>>(), this.equipments = const AsyncLoading<List<Equipment>>()});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  AsyncValue<List<BodyPart>> bodyParts;
@override@JsonKey() final  AsyncValue<List<Equipment>> equipments;

/// Create a copy of ExerciseCreationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseCreationStateCopyWith<_ExerciseCreationState> get copyWith => __$ExerciseCreationStateCopyWithImpl<_ExerciseCreationState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExerciseCreationState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('bodyParts', bodyParts))..add(DiagnosticsProperty('equipments', equipments));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseCreationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.bodyParts, bodyParts) || other.bodyParts == bodyParts)&&(identical(other.equipments, equipments) || other.equipments == equipments));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,bodyParts,equipments);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExerciseCreationState(isLoading: $isLoading, bodyParts: $bodyParts, equipments: $equipments)';
}


}

/// @nodoc
abstract mixin class _$ExerciseCreationStateCopyWith<$Res> implements $ExerciseCreationStateCopyWith<$Res> {
  factory _$ExerciseCreationStateCopyWith(_ExerciseCreationState value, $Res Function(_ExerciseCreationState) _then) = __$ExerciseCreationStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, AsyncValue<List<BodyPart>> bodyParts, AsyncValue<List<Equipment>> equipments
});




}
/// @nodoc
class __$ExerciseCreationStateCopyWithImpl<$Res>
    implements _$ExerciseCreationStateCopyWith<$Res> {
  __$ExerciseCreationStateCopyWithImpl(this._self, this._then);

  final _ExerciseCreationState _self;
  final $Res Function(_ExerciseCreationState) _then;

/// Create a copy of ExerciseCreationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? bodyParts = null,Object? equipments = null,}) {
  return _then(_ExerciseCreationState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,bodyParts: null == bodyParts ? _self.bodyParts : bodyParts // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<BodyPart>>,equipments: null == equipments ? _self.equipments : equipments // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<Equipment>>,
  ));
}


}

// dart format on
