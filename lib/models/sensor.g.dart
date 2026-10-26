// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Sensor _$SensorFromJson(Map<String, dynamic> json) => _Sensor(
  id: json['id'] as String,
  name: json['name'] as String,
  location: json['location'] as String,
  isOnline: json['isOnline'] as bool,
  value: (json['value'] as num).toDouble(),
  unit: json['unit'] as String,
  batteryLevel: (json['batteryLevel'] as num).toInt(),
  lastUpdated: json['lastUpdated'] as String,
);

Map<String, dynamic> _$SensorToJson(_Sensor instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'location': instance.location,
  'isOnline': instance.isOnline,
  'value': instance.value,
  'unit': instance.unit,
  'batteryLevel': instance.batteryLevel,
  'lastUpdated': instance.lastUpdated,
};
