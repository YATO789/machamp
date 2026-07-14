// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkoutHistoryEntry {

 String get id; String? get menuName; DateTime get startedAt; DateTime get finishedAt; List<WorkoutHistoryExercise> get exercises;
/// Create a copy of WorkoutHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutHistoryEntryCopyWith<WorkoutHistoryEntry> get copyWith => _$WorkoutHistoryEntryCopyWithImpl<WorkoutHistoryEntry>(this as WorkoutHistoryEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutHistoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.menuName, menuName) || other.menuName == menuName)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}


@override
int get hashCode => Object.hash(runtimeType,id,menuName,startedAt,finishedAt,const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'WorkoutHistoryEntry(id: $id, menuName: $menuName, startedAt: $startedAt, finishedAt: $finishedAt, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $WorkoutHistoryEntryCopyWith<$Res>  {
  factory $WorkoutHistoryEntryCopyWith(WorkoutHistoryEntry value, $Res Function(WorkoutHistoryEntry) _then) = _$WorkoutHistoryEntryCopyWithImpl;
@useResult
$Res call({
 String id, String? menuName, DateTime startedAt, DateTime finishedAt, List<WorkoutHistoryExercise> exercises
});




}
/// @nodoc
class _$WorkoutHistoryEntryCopyWithImpl<$Res>
    implements $WorkoutHistoryEntryCopyWith<$Res> {
  _$WorkoutHistoryEntryCopyWithImpl(this._self, this._then);

  final WorkoutHistoryEntry _self;
  final $Res Function(WorkoutHistoryEntry) _then;

/// Create a copy of WorkoutHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? menuName = freezed,Object? startedAt = null,Object? finishedAt = null,Object? exercises = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,menuName: freezed == menuName ? _self.menuName : menuName // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: null == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<WorkoutHistoryExercise>,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutHistoryEntry].
extension WorkoutHistoryEntryPatterns on WorkoutHistoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutHistoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutHistoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutHistoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutHistoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? menuName,  DateTime startedAt,  DateTime finishedAt,  List<WorkoutHistoryExercise> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutHistoryEntry() when $default != null:
return $default(_that.id,_that.menuName,_that.startedAt,_that.finishedAt,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? menuName,  DateTime startedAt,  DateTime finishedAt,  List<WorkoutHistoryExercise> exercises)  $default,) {final _that = this;
switch (_that) {
case _WorkoutHistoryEntry():
return $default(_that.id,_that.menuName,_that.startedAt,_that.finishedAt,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? menuName,  DateTime startedAt,  DateTime finishedAt,  List<WorkoutHistoryExercise> exercises)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutHistoryEntry() when $default != null:
return $default(_that.id,_that.menuName,_that.startedAt,_that.finishedAt,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc


class _WorkoutHistoryEntry implements WorkoutHistoryEntry {
  const _WorkoutHistoryEntry({required this.id, this.menuName, required this.startedAt, required this.finishedAt, required final  List<WorkoutHistoryExercise> exercises}): _exercises = exercises;
  

@override final  String id;
@override final  String? menuName;
@override final  DateTime startedAt;
@override final  DateTime finishedAt;
 final  List<WorkoutHistoryExercise> _exercises;
@override List<WorkoutHistoryExercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of WorkoutHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutHistoryEntryCopyWith<_WorkoutHistoryEntry> get copyWith => __$WorkoutHistoryEntryCopyWithImpl<_WorkoutHistoryEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutHistoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.menuName, menuName) || other.menuName == menuName)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}


@override
int get hashCode => Object.hash(runtimeType,id,menuName,startedAt,finishedAt,const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'WorkoutHistoryEntry(id: $id, menuName: $menuName, startedAt: $startedAt, finishedAt: $finishedAt, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$WorkoutHistoryEntryCopyWith<$Res> implements $WorkoutHistoryEntryCopyWith<$Res> {
  factory _$WorkoutHistoryEntryCopyWith(_WorkoutHistoryEntry value, $Res Function(_WorkoutHistoryEntry) _then) = __$WorkoutHistoryEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String? menuName, DateTime startedAt, DateTime finishedAt, List<WorkoutHistoryExercise> exercises
});




}
/// @nodoc
class __$WorkoutHistoryEntryCopyWithImpl<$Res>
    implements _$WorkoutHistoryEntryCopyWith<$Res> {
  __$WorkoutHistoryEntryCopyWithImpl(this._self, this._then);

  final _WorkoutHistoryEntry _self;
  final $Res Function(_WorkoutHistoryEntry) _then;

/// Create a copy of WorkoutHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? menuName = freezed,Object? startedAt = null,Object? finishedAt = null,Object? exercises = null,}) {
  return _then(_WorkoutHistoryEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,menuName: freezed == menuName ? _self.menuName : menuName // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: null == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<WorkoutHistoryExercise>,
  ));
}


}

/// @nodoc
mixin _$WorkoutHistoryExercise {

 String get exerciseName; List<WorkoutHistorySet> get sets;
/// Create a copy of WorkoutHistoryExercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutHistoryExerciseCopyWith<WorkoutHistoryExercise> get copyWith => _$WorkoutHistoryExerciseCopyWithImpl<WorkoutHistoryExercise>(this as WorkoutHistoryExercise, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutHistoryExercise&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&const DeepCollectionEquality().equals(other.sets, sets));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseName,const DeepCollectionEquality().hash(sets));

@override
String toString() {
  return 'WorkoutHistoryExercise(exerciseName: $exerciseName, sets: $sets)';
}


}

/// @nodoc
abstract mixin class $WorkoutHistoryExerciseCopyWith<$Res>  {
  factory $WorkoutHistoryExerciseCopyWith(WorkoutHistoryExercise value, $Res Function(WorkoutHistoryExercise) _then) = _$WorkoutHistoryExerciseCopyWithImpl;
@useResult
$Res call({
 String exerciseName, List<WorkoutHistorySet> sets
});




}
/// @nodoc
class _$WorkoutHistoryExerciseCopyWithImpl<$Res>
    implements $WorkoutHistoryExerciseCopyWith<$Res> {
  _$WorkoutHistoryExerciseCopyWithImpl(this._self, this._then);

  final WorkoutHistoryExercise _self;
  final $Res Function(WorkoutHistoryExercise) _then;

/// Create a copy of WorkoutHistoryExercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exerciseName = null,Object? sets = null,}) {
  return _then(_self.copyWith(
exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<WorkoutHistorySet>,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutHistoryExercise].
extension WorkoutHistoryExercisePatterns on WorkoutHistoryExercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutHistoryExercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutHistoryExercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutHistoryExercise value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutHistoryExercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutHistoryExercise value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutHistoryExercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String exerciseName,  List<WorkoutHistorySet> sets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutHistoryExercise() when $default != null:
return $default(_that.exerciseName,_that.sets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String exerciseName,  List<WorkoutHistorySet> sets)  $default,) {final _that = this;
switch (_that) {
case _WorkoutHistoryExercise():
return $default(_that.exerciseName,_that.sets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String exerciseName,  List<WorkoutHistorySet> sets)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutHistoryExercise() when $default != null:
return $default(_that.exerciseName,_that.sets);case _:
  return null;

}
}

}

/// @nodoc


class _WorkoutHistoryExercise implements WorkoutHistoryExercise {
  const _WorkoutHistoryExercise({required this.exerciseName, required final  List<WorkoutHistorySet> sets}): _sets = sets;
  

@override final  String exerciseName;
 final  List<WorkoutHistorySet> _sets;
@override List<WorkoutHistorySet> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}


/// Create a copy of WorkoutHistoryExercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutHistoryExerciseCopyWith<_WorkoutHistoryExercise> get copyWith => __$WorkoutHistoryExerciseCopyWithImpl<_WorkoutHistoryExercise>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutHistoryExercise&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&const DeepCollectionEquality().equals(other._sets, _sets));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseName,const DeepCollectionEquality().hash(_sets));

@override
String toString() {
  return 'WorkoutHistoryExercise(exerciseName: $exerciseName, sets: $sets)';
}


}

/// @nodoc
abstract mixin class _$WorkoutHistoryExerciseCopyWith<$Res> implements $WorkoutHistoryExerciseCopyWith<$Res> {
  factory _$WorkoutHistoryExerciseCopyWith(_WorkoutHistoryExercise value, $Res Function(_WorkoutHistoryExercise) _then) = __$WorkoutHistoryExerciseCopyWithImpl;
@override @useResult
$Res call({
 String exerciseName, List<WorkoutHistorySet> sets
});




}
/// @nodoc
class __$WorkoutHistoryExerciseCopyWithImpl<$Res>
    implements _$WorkoutHistoryExerciseCopyWith<$Res> {
  __$WorkoutHistoryExerciseCopyWithImpl(this._self, this._then);

  final _WorkoutHistoryExercise _self;
  final $Res Function(_WorkoutHistoryExercise) _then;

/// Create a copy of WorkoutHistoryExercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exerciseName = null,Object? sets = null,}) {
  return _then(_WorkoutHistoryExercise(
exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<WorkoutHistorySet>,
  ));
}


}

/// @nodoc
mixin _$WorkoutHistorySet {

 int get reps; double get weight; int get intervalSeconds;
/// Create a copy of WorkoutHistorySet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutHistorySetCopyWith<WorkoutHistorySet> get copyWith => _$WorkoutHistorySetCopyWithImpl<WorkoutHistorySet>(this as WorkoutHistorySet, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutHistorySet&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.intervalSeconds, intervalSeconds) || other.intervalSeconds == intervalSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,reps,weight,intervalSeconds);

@override
String toString() {
  return 'WorkoutHistorySet(reps: $reps, weight: $weight, intervalSeconds: $intervalSeconds)';
}


}

/// @nodoc
abstract mixin class $WorkoutHistorySetCopyWith<$Res>  {
  factory $WorkoutHistorySetCopyWith(WorkoutHistorySet value, $Res Function(WorkoutHistorySet) _then) = _$WorkoutHistorySetCopyWithImpl;
@useResult
$Res call({
 int reps, double weight, int intervalSeconds
});




}
/// @nodoc
class _$WorkoutHistorySetCopyWithImpl<$Res>
    implements $WorkoutHistorySetCopyWith<$Res> {
  _$WorkoutHistorySetCopyWithImpl(this._self, this._then);

  final WorkoutHistorySet _self;
  final $Res Function(WorkoutHistorySet) _then;

/// Create a copy of WorkoutHistorySet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reps = null,Object? weight = null,Object? intervalSeconds = null,}) {
  return _then(_self.copyWith(
reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,intervalSeconds: null == intervalSeconds ? _self.intervalSeconds : intervalSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutHistorySet].
extension WorkoutHistorySetPatterns on WorkoutHistorySet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutHistorySet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutHistorySet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutHistorySet value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutHistorySet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutHistorySet value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutHistorySet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int reps,  double weight,  int intervalSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutHistorySet() when $default != null:
return $default(_that.reps,_that.weight,_that.intervalSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int reps,  double weight,  int intervalSeconds)  $default,) {final _that = this;
switch (_that) {
case _WorkoutHistorySet():
return $default(_that.reps,_that.weight,_that.intervalSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int reps,  double weight,  int intervalSeconds)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutHistorySet() when $default != null:
return $default(_that.reps,_that.weight,_that.intervalSeconds);case _:
  return null;

}
}

}

/// @nodoc


class _WorkoutHistorySet implements WorkoutHistorySet {
  const _WorkoutHistorySet({required this.reps, required this.weight, required this.intervalSeconds});
  

@override final  int reps;
@override final  double weight;
@override final  int intervalSeconds;

/// Create a copy of WorkoutHistorySet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutHistorySetCopyWith<_WorkoutHistorySet> get copyWith => __$WorkoutHistorySetCopyWithImpl<_WorkoutHistorySet>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutHistorySet&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.intervalSeconds, intervalSeconds) || other.intervalSeconds == intervalSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,reps,weight,intervalSeconds);

@override
String toString() {
  return 'WorkoutHistorySet(reps: $reps, weight: $weight, intervalSeconds: $intervalSeconds)';
}


}

/// @nodoc
abstract mixin class _$WorkoutHistorySetCopyWith<$Res> implements $WorkoutHistorySetCopyWith<$Res> {
  factory _$WorkoutHistorySetCopyWith(_WorkoutHistorySet value, $Res Function(_WorkoutHistorySet) _then) = __$WorkoutHistorySetCopyWithImpl;
@override @useResult
$Res call({
 int reps, double weight, int intervalSeconds
});




}
/// @nodoc
class __$WorkoutHistorySetCopyWithImpl<$Res>
    implements _$WorkoutHistorySetCopyWith<$Res> {
  __$WorkoutHistorySetCopyWithImpl(this._self, this._then);

  final _WorkoutHistorySet _self;
  final $Res Function(_WorkoutHistorySet) _then;

/// Create a copy of WorkoutHistorySet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reps = null,Object? weight = null,Object? intervalSeconds = null,}) {
  return _then(_WorkoutHistorySet(
reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,intervalSeconds: null == intervalSeconds ? _self.intervalSeconds : intervalSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
