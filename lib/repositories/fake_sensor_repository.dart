import '../models/sensor.dart';
import 'sensor_repository.dart';

class FakeSensorRepository implements SensorRepository {
  FakeSensorRepository({
    List<Sensor>? sensors,
    this.delay = const Duration(seconds: 3),
    this.remainingFailures = 0,
  }) : _sensors =
           sensors ??
           const <Sensor>[
             Sensor(
               id: 'sensor-001',
               name: 'Capteur température',
               location: 'Salon',
               isOnline: true,
               value: 21.8,
               unit: '°C',
               batteryLevel: 86,
               lastUpdated: 'Il y a 2 min',
             ),
             Sensor(
               id: 'sensor-002',
               name: 'Capteur humidité',
               location: 'Serre',
               isOnline: true,
               value: 64,
               unit: '%',
               batteryLevel: 72,
               lastUpdated: 'Il y a 5 min',
             ),
             Sensor(
               id: 'sensor-003',
               name: 'Capteur luminosité',
               location: 'Balcon',
               isOnline: false,
               value: 340,
               unit: 'lx',
               batteryLevel: 18,
               lastUpdated: 'Il y a 1 h',
             ),
           ];

  final List<Sensor> _sensors;
  final Duration delay;

  /// Nombre d'échecs restants avant de laisser passer un succès.
  int remainingFailures;

  /// Si true, le prochain `fetchAll` échoue une seule fois.
  bool failNext = false;

  /// Compteur d'observation : combien de chargements ont vraiment démarré.
  int fetchCount = 0;

  void armNextFailure() {
    failNext = true;
  }

  @override
  Future<List<Sensor>> fetchAll() async {
    fetchCount++;
    await Future<void>.delayed(delay);

    if (failNext) {
      failNext = false;
      throw Exception('Impossible de charger les capteurs.');
    }

    if (remainingFailures > 0) {
      remainingFailures--;
      throw Exception('Impossible de charger les capteurs.');
    }

    return List<Sensor>.from(_sensors);
  }
}
