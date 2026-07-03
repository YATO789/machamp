// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_preview_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SharePreviewState {

 bool get isSharing;
/// Create a copy of SharePreviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharePreviewStateCopyWith<SharePreviewState> get copyWith => _$SharePreviewStateCopyWithImpl<SharePreviewState>(this as SharePreviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharePreviewState&&(identical(other.isSharing, isSharing) || other.isSharing == isSharing));
}


@override
int get hashCode => Object.hash(runtimeType,isSharing);

@override
String toString() {
  return 'SharePreviewState(isSharing: $isSharing)';
}


}

/// @nodoc
abstract mixin class $SharePreviewStateCopyWith<$Res>  {
  factory $SharePreviewStateCopyWith(SharePreviewState value, $Res Function(SharePreviewState) _then) = _$SharePreviewStateCopyWithImpl;
@useResult
$Res call({
 bool isSharing
});




}
/// @nodoc
class _$SharePreviewStateCopyWithImpl<$Res>
    implements $SharePreviewStateCopyWith<$Res> {
  _$SharePreviewStateCopyWithImpl(this._self, this._then);

  final SharePreviewState _self;
  final $Res Function(SharePreviewState) _then;

/// Create a copy of SharePreviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSharing = null,}) {
  return _then(_self.copyWith(
isSharing: null == isSharing ? _self.isSharing : isSharing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SharePreviewState].
extension SharePreviewStatePatterns on SharePreviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharePreviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharePreviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharePreviewState value)  $default,){
final _that = this;
switch (_that) {
case _SharePreviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharePreviewState value)?  $default,){
final _that = this;
switch (_that) {
case _SharePreviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSharing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharePreviewState() when $default != null:
return $default(_that.isSharing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSharing)  $default,) {final _that = this;
switch (_that) {
case _SharePreviewState():
return $default(_that.isSharing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSharing)?  $default,) {final _that = this;
switch (_that) {
case _SharePreviewState() when $default != null:
return $default(_that.isSharing);case _:
  return null;

}
}

}

/// @nodoc


class _SharePreviewState implements SharePreviewState {
  const _SharePreviewState({this.isSharing = false});
  

@override@JsonKey() final  bool isSharing;

/// Create a copy of SharePreviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharePreviewStateCopyWith<_SharePreviewState> get copyWith => __$SharePreviewStateCopyWithImpl<_SharePreviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharePreviewState&&(identical(other.isSharing, isSharing) || other.isSharing == isSharing));
}


@override
int get hashCode => Object.hash(runtimeType,isSharing);

@override
String toString() {
  return 'SharePreviewState(isSharing: $isSharing)';
}


}

/// @nodoc
abstract mixin class _$SharePreviewStateCopyWith<$Res> implements $SharePreviewStateCopyWith<$Res> {
  factory _$SharePreviewStateCopyWith(_SharePreviewState value, $Res Function(_SharePreviewState) _then) = __$SharePreviewStateCopyWithImpl;
@override @useResult
$Res call({
 bool isSharing
});




}
/// @nodoc
class __$SharePreviewStateCopyWithImpl<$Res>
    implements _$SharePreviewStateCopyWith<$Res> {
  __$SharePreviewStateCopyWithImpl(this._self, this._then);

  final _SharePreviewState _self;
  final $Res Function(_SharePreviewState) _then;

/// Create a copy of SharePreviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSharing = null,}) {
  return _then(_SharePreviewState(
isSharing: null == isSharing ? _self.isSharing : isSharing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
