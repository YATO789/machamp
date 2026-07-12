// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_part.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BodyPart {

 String get id; String get name; int get sortOrder;
/// Create a copy of BodyPart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyPartCopyWith<BodyPart> get copyWith => _$BodyPartCopyWithImpl<BodyPart>(this as BodyPart, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyPart&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder);

@override
String toString() {
  return 'BodyPart(id: $id, name: $name, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $BodyPartCopyWith<$Res>  {
  factory $BodyPartCopyWith(BodyPart value, $Res Function(BodyPart) _then) = _$BodyPartCopyWithImpl;
@useResult
$Res call({
 String id, String name, int sortOrder
});




}
/// @nodoc
class _$BodyPartCopyWithImpl<$Res>
    implements $BodyPartCopyWith<$Res> {
  _$BodyPartCopyWithImpl(this._self, this._then);

  final BodyPart _self;
  final $Res Function(BodyPart) _then;

/// Create a copy of BodyPart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyPart].
extension BodyPartPatterns on BodyPart {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyPart value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyPart() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyPart value)  $default,){
final _that = this;
switch (_that) {
case _BodyPart():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyPart value)?  $default,){
final _that = this;
switch (_that) {
case _BodyPart() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyPart() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _BodyPart():
return $default(_that.id,_that.name,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _BodyPart() when $default != null:
return $default(_that.id,_that.name,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _BodyPart implements BodyPart {
  const _BodyPart({required this.id, required this.name, required this.sortOrder});
  

@override final  String id;
@override final  String name;
@override final  int sortOrder;

/// Create a copy of BodyPart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyPartCopyWith<_BodyPart> get copyWith => __$BodyPartCopyWithImpl<_BodyPart>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyPart&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,sortOrder);

@override
String toString() {
  return 'BodyPart(id: $id, name: $name, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$BodyPartCopyWith<$Res> implements $BodyPartCopyWith<$Res> {
  factory _$BodyPartCopyWith(_BodyPart value, $Res Function(_BodyPart) _then) = __$BodyPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int sortOrder
});




}
/// @nodoc
class __$BodyPartCopyWithImpl<$Res>
    implements _$BodyPartCopyWith<$Res> {
  __$BodyPartCopyWithImpl(this._self, this._then);

  final _BodyPart _self;
  final $Res Function(_BodyPart) _then;

/// Create a copy of BodyPart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sortOrder = null,}) {
  return _then(_BodyPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
