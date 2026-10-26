import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor.freezed.dart';
part 'sensor.g.dart';

@freezed
abstract class Sensor with _$Sensor {
  const factory Sensor({
    required String id,
    required String name,
    required String location,
    required bool isOnline,
    required double value,
    required String unit,
    required int batteryLevel,
    required String lastUpdated,
  }) = _Sensor;

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);
}
