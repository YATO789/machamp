// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkoutSetState {

 double get weight; int get reps; bool get isCompleted;
/// Create a copy of WorkoutSetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutSetStateCopyWith<WorkoutSetState> get copyWith => _$WorkoutSetStateCopyWithImpl<WorkoutSetState>(this as WorkoutSetState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutSetState&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,weight,reps,isCompleted);

@override
String toString() {
  return 'WorkoutSetState(weight: $weight, reps: $reps, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $WorkoutSetStateCopyWith<$Res>  {
  factory $WorkoutSetStateCopyWith(WorkoutSetState value, $Res Function(WorkoutSetState) _then) = _$WorkoutSetStateCopyWithImpl;
@useResult
$Res call({
 double weight, int reps, bool isCompleted
});




}
/// @nodoc
class _$WorkoutSetStateCopyWithImpl<$Res>
    implements $WorkoutSetStateCopyWith<$Res> {
  _$WorkoutSetStateCopyWithImpl(this._self, this._then);

  final WorkoutSetState _self;
  final $Res Function(WorkoutSetState) _then;

/// Create a copy of WorkoutSetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weight = null,Object? reps = null,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutSetState].
extension WorkoutSetStatePatterns on WorkoutSetState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutSetState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutSetState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutSetState value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutSetState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutSetState value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutSetState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double weight,  int reps,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutSetState() when $default != null:
return $default(_that.weight,_that.reps,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double weight,  int reps,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _WorkoutSetState():
return $default(_that.weight,_that.reps,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double weight,  int reps,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutSetState() when $default != null:
return $default(_that.weight,_that.reps,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc


class _WorkoutSetState implements WorkoutSetState {
  const _WorkoutSetState({required this.weight, required this.reps, this.isCompleted = false});
  

@override final  double weight;
@override final  int reps;
@override@JsonKey() final  bool isCompleted;

/// Create a copy of WorkoutSetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutSetStateCopyWith<_WorkoutSetState> get copyWith => __$WorkoutSetStateCopyWithImpl<_WorkoutSetState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutSetState&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,weight,reps,isCompleted);

@override
String toString() {
  return 'WorkoutSetState(weight: $weight, reps: $reps, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$WorkoutSetStateCopyWith<$Res> implements $WorkoutSetStateCopyWith<$Res> {
  factory _$WorkoutSetStateCopyWith(_WorkoutSetState value, $Res Function(_WorkoutSetState) _then) = __$WorkoutSetStateCopyWithImpl;
@override @useResult
$Res call({
 double weight, int reps, bool isCompleted
});




}
/// @nodoc
class __$WorkoutSetStateCopyWithImpl<$Res>
    implements _$WorkoutSetStateCopyWith<$Res> {
  __$WorkoutSetStateCopyWithImpl(this._self, this._then);

  final _WorkoutSetState _self;
  final $Res Function(_WorkoutSetState) _then;

/// Create a copy of WorkoutSetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weight = null,Object? reps = null,Object? isCompleted = null,}) {
  return _then(_WorkoutSetState(
weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$WorkoutExerciseState {

 Exercise get exercise; List<WorkoutSetState> get sets; bool get isCompleted;
/// Create a copy of WorkoutExerciseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutExerciseStateCopyWith<WorkoutExerciseState> get copyWith => _$WorkoutExerciseStateCopyWithImpl<WorkoutExerciseState>(this as WorkoutExerciseState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutExerciseState&&(identical(other.exercise, exercise) || other.exercise == exercise)&&const DeepCollectionEquality().equals(other.sets, sets)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,exercise,const DeepCollectionEquality().hash(sets),isCompleted);

@override
String toString() {
  return 'WorkoutExerciseState(exercise: $exercise, sets: $sets, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $WorkoutExerciseStateCopyWith<$Res>  {
  factory $WorkoutExerciseStateCopyWith(WorkoutExerciseState value, $Res Function(WorkoutExerciseState) _then) = _$WorkoutExerciseStateCopyWithImpl;
@useResult
$Res call({
 Exercise exercise, List<WorkoutSetState> sets, bool isCompleted
});


$ExerciseCopyWith<$Res> get exercise;

}
/// @nodoc
class _$WorkoutExerciseStateCopyWithImpl<$Res>
    implements $WorkoutExerciseStateCopyWith<$Res> {
  _$WorkoutExerciseStateCopyWithImpl(this._self, this._then);

  final WorkoutExerciseState _self;
  final $Res Function(WorkoutExerciseState) _then;

/// Create a copy of WorkoutExerciseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exercise = null,Object? sets = null,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as Exercise,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<WorkoutSetState>,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of WorkoutExerciseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExerciseCopyWith<$Res> get exercise {
  
  return $ExerciseCopyWith<$Res>(_self.exercise, (value) {
    return _then(_self.copyWith(exercise: value));
  });
}
}


/// Adds pattern-matching-related methods to [WorkoutExerciseState].
extension WorkoutExerciseStatePatterns on WorkoutExerciseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutExerciseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutExerciseState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutExerciseState value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutExerciseState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutExerciseState value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutExerciseState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Exercise exercise,  List<WorkoutSetState> sets,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutExerciseState() when $default != null:
return $default(_that.exercise,_that.sets,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Exercise exercise,  List<WorkoutSetState> sets,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _WorkoutExerciseState():
return $default(_that.exercise,_that.sets,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Exercise exercise,  List<WorkoutSetState> sets,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutExerciseState() when $default != null:
return $default(_that.exercise,_that.sets,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc


class _WorkoutExerciseState implements WorkoutExerciseState {
  const _WorkoutExerciseState({required this.exercise, required final  List<WorkoutSetState> sets, this.isCompleted = false}): _sets = sets;
  

@override final  Exercise exercise;
 final  List<WorkoutSetState> _sets;
@override List<WorkoutSetState> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

@override@JsonKey() final  bool isCompleted;

/// Create a copy of WorkoutExerciseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutExerciseStateCopyWith<_WorkoutExerciseState> get copyWith => __$WorkoutExerciseStateCopyWithImpl<_WorkoutExerciseState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutExerciseState&&(identical(other.exercise, exercise) || other.exercise == exercise)&&const DeepCollectionEquality().equals(other._sets, _sets)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,exercise,const DeepCollectionEquality().hash(_sets),isCompleted);

@override
String toString() {
  return 'WorkoutExerciseState(exercise: $exercise, sets: $sets, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$WorkoutExerciseStateCopyWith<$Res> implements $WorkoutExerciseStateCopyWith<$Res> {
  factory _$WorkoutExerciseStateCopyWith(_WorkoutExerciseState value, $Res Function(_WorkoutExerciseState) _then) = __$WorkoutExerciseStateCopyWithImpl;
@override @useResult
$Res call({
 Exercise exercise, List<WorkoutSetState> sets, bool isCompleted
});


@override $ExerciseCopyWith<$Res> get exercise;

}
/// @nodoc
class __$WorkoutExerciseStateCopyWithImpl<$Res>
    implements _$WorkoutExerciseStateCopyWith<$Res> {
  __$WorkoutExerciseStateCopyWithImpl(this._self, this._then);

  final _WorkoutExerciseState _self;
  final $Res Function(_WorkoutExerciseState) _then;

/// Create a copy of WorkoutExerciseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exercise = null,Object? sets = null,Object? isCompleted = null,}) {
  return _then(_WorkoutExerciseState(
exercise: null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as Exercise,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<WorkoutSetState>,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of WorkoutExerciseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExerciseCopyWith<$Res> get exercise {
  
  return $ExerciseCopyWith<$Res>(_self.exercise, (value) {
    return _then(_self.copyWith(exercise: value));
  });
}
}

/// @nodoc
mixin _$WorkoutState {

 String get menuName; List<WorkoutExerciseState> get exercises; DateTime? get startedAt; DateTime? get finishedAt;
/// Create a copy of WorkoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutStateCopyWith<WorkoutState> get copyWith => _$WorkoutStateCopyWithImpl<WorkoutState>(this as WorkoutState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutState&&(identical(other.menuName, menuName) || other.menuName == menuName)&&const DeepCollectionEquality().equals(other.exercises, exercises)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt));
}


@override
int get hashCode => Object.hash(runtimeType,menuName,const DeepCollectionEquality().hash(exercises),startedAt,finishedAt);

@override
String toString() {
  return 'WorkoutState(menuName: $menuName, exercises: $exercises, startedAt: $startedAt, finishedAt: $finishedAt)';
}


}

/// @nodoc
abstract mixin class $WorkoutStateCopyWith<$Res>  {
  factory $WorkoutStateCopyWith(WorkoutState value, $Res Function(WorkoutState) _then) = _$WorkoutStateCopyWithImpl;
@useResult
$Res call({
 String menuName, List<WorkoutExerciseState> exercises, DateTime? startedAt, DateTime? finishedAt
});




}
/// @nodoc
class _$WorkoutStateCopyWithImpl<$Res>
    implements $WorkoutStateCopyWith<$Res> {
  _$WorkoutStateCopyWithImpl(this._self, this._then);

  final WorkoutState _self;
  final $Res Function(WorkoutState) _then;

/// Create a copy of WorkoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? menuName = null,Object? exercises = null,Object? startedAt = freezed,Object? finishedAt = freezed,}) {
  return _then(_self.copyWith(
menuName: null == menuName ? _self.menuName : menuName // ignore: cast_nullable_to_non_nullable
as String,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<WorkoutExerciseState>,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutState].
extension WorkoutStatePatterns on WorkoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutState value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutState value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String menuName,  List<WorkoutExerciseState> exercises,  DateTime? startedAt,  DateTime? finishedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutState() when $default != null:
return $default(_that.menuName,_that.exercises,_that.startedAt,_that.finishedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String menuName,  List<WorkoutExerciseState> exercises,  DateTime? startedAt,  DateTime? finishedAt)  $default,) {final _that = this;
switch (_that) {
case _WorkoutState():
return $default(_that.menuName,_that.exercises,_that.startedAt,_that.finishedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String menuName,  List<WorkoutExerciseState> exercises,  DateTime? startedAt,  DateTime? finishedAt)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutState() when $default != null:
return $default(_that.menuName,_that.exercises,_that.startedAt,_that.finishedAt);case _:
  return null;

}
}

}

/// @nodoc


class _WorkoutState implements WorkoutState {
  const _WorkoutState({this.menuName = '', final  List<WorkoutExerciseState> exercises = const [], this.startedAt, this.finishedAt}): _exercises = exercises;
  

@override@JsonKey() final  String menuName;
 final  List<WorkoutExerciseState> _exercises;
@override@JsonKey() List<WorkoutExerciseState> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}

@override final  DateTime? startedAt;
@override final  DateTime? finishedAt;

/// Create a copy of WorkoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutStateCopyWith<_WorkoutState> get copyWith => __$WorkoutStateCopyWithImpl<_WorkoutState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutState&&(identical(other.menuName, menuName) || other.menuName == menuName)&&const DeepCollectionEquality().equals(other._exercises, _exercises)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt));
}


@override
int get hashCode => Object.hash(runtimeType,menuName,const DeepCollectionEquality().hash(_exercises),startedAt,finishedAt);

@override
String toString() {
  return 'WorkoutState(menuName: $menuName, exercises: $exercises, startedAt: $startedAt, finishedAt: $finishedAt)';
}


}

/// @nodoc
abstract mixin class _$WorkoutStateCopyWith<$Res> implements $WorkoutStateCopyWith<$Res> {
  factory _$WorkoutStateCopyWith(_WorkoutState value, $Res Function(_WorkoutState) _then) = __$WorkoutStateCopyWithImpl;
@override @useResult
$Res call({
 String menuName, List<WorkoutExerciseState> exercises, DateTime? startedAt, DateTime? finishedAt
});




}
/// @nodoc
class __$WorkoutStateCopyWithImpl<$Res>
    implements _$WorkoutStateCopyWith<$Res> {
  __$WorkoutStateCopyWithImpl(this._self, this._then);

  final _WorkoutState _self;
  final $Res Function(_WorkoutState) _then;

/// Create a copy of WorkoutState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? menuName = null,Object? exercises = null,Object? startedAt = freezed,Object? finishedAt = freezed,}) {
  return _then(_WorkoutState(
menuName: null == menuName ? _self.menuName : menuName // ignore: cast_nullable_to_non_nullable
as String,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<WorkoutExerciseState>,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
