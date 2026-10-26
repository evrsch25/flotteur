// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Sensor {

 String get id; String get name; String get location; bool get isOnline; double get value; String get unit; int get batteryLevel; String get lastUpdated;
/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SensorCopyWith<Sensor> get copyWith => _$SensorCopyWithImpl<Sensor>(this as Sensor, _$identity);

  /// Serializes this Sensor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sensor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.batteryLevel, batteryLevel) || other.batteryLevel == batteryLevel)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,location,isOnline,value,unit,batteryLevel,lastUpdated);

@override
String toString() {
  return 'Sensor(id: $id, name: $name, location: $location, isOnline: $isOnline, value: $value, unit: $unit, batteryLevel: $batteryLevel, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $SensorCopyWith<$Res>  {
  factory $SensorCopyWith(Sensor value, $Res Function(Sensor) _then) = _$SensorCopyWithImpl;
@useResult
$Res call({
 String id, String name, String location, bool isOnline, double value, String unit, int batteryLevel, String lastUpdated
});




}
/// @nodoc
class _$SensorCopyWithImpl<$Res>
    implements $SensorCopyWith<$Res> {
  _$SensorCopyWithImpl(this._self, this._then);

  final Sensor _self;
  final $Res Function(Sensor) _then;

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? location = null,Object? isOnline = null,Object? value = null,Object? unit = null,Object? batteryLevel = null,Object? lastUpdated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,batteryLevel: null == batteryLevel ? _self.batteryLevel : batteryLevel // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Sensor].
extension SensorPatterns on Sensor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Sensor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Sensor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Sensor value)  $default,){
final _that = this;
switch (_that) {
case _Sensor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Sensor value)?  $default,){
final _that = this;
switch (_that) {
case _Sensor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String location,  bool isOnline,  double value,  String unit,  int batteryLevel,  String lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Sensor() when $default != null:
return $default(_that.id,_that.name,_that.location,_that.isOnline,_that.value,_that.unit,_that.batteryLevel,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String location,  bool isOnline,  double value,  String unit,  int batteryLevel,  String lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _Sensor():
return $default(_that.id,_that.name,_that.location,_that.isOnline,_that.value,_that.unit,_that.batteryLevel,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String location,  bool isOnline,  double value,  String unit,  int batteryLevel,  String lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _Sensor() when $default != null:
return $default(_that.id,_that.name,_that.location,_that.isOnline,_that.value,_that.unit,_that.batteryLevel,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Sensor implements Sensor {
  const _Sensor({required this.id, required this.name, required this.location, required this.isOnline, required this.value, required this.unit, required this.batteryLevel, required this.lastUpdated});
  factory _Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

@override final  String id;
@override final  String name;
@override final  String location;
@override final  bool isOnline;
@override final  double value;
@override final  String unit;
@override final  int batteryLevel;
@override final  String lastUpdated;

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SensorCopyWith<_Sensor> get copyWith => __$SensorCopyWithImpl<_Sensor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SensorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sensor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.batteryLevel, batteryLevel) || other.batteryLevel == batteryLevel)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,location,isOnline,value,unit,batteryLevel,lastUpdated);

@override
String toString() {
  return 'Sensor(id: $id, name: $name, location: $location, isOnline: $isOnline, value: $value, unit: $unit, batteryLevel: $batteryLevel, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$SensorCopyWith<$Res> implements $SensorCopyWith<$Res> {
  factory _$SensorCopyWith(_Sensor value, $Res Function(_Sensor) _then) = __$SensorCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String location, bool isOnline, double value, String unit, int batteryLevel, String lastUpdated
});




}
/// @nodoc
class __$SensorCopyWithImpl<$Res>
    implements _$SensorCopyWith<$Res> {
  __$SensorCopyWithImpl(this._self, this._then);

  final _Sensor _self;
  final $Res Function(_Sensor) _then;

/// Create a copy of Sensor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? location = null,Object? isOnline = null,Object? value = null,Object? unit = null,Object? batteryLevel = null,Object? lastUpdated = null,}) {
  return _then(_Sensor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,batteryLevel: null == batteryLevel ? _self.batteryLevel : batteryLevel // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
