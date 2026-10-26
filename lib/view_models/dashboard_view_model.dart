import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/sensor.dart';
import '../repositories/sensor_repository.dart';
import '../states/async_state.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel({required SensorRepository repository})
    : _repository = repository;

  /// Seuil démo pour les données anciennes (atelier : 10 s au lieu de 30 s).
  static const Duration staleAfter = Duration(seconds: 10);

  final SensorRepository _repository;
  AsyncState<Sensor> _state = const Loading<Sensor>();
  bool _isLoading = false;
  DateTime? _lastSuccessfulAt;
  Timer? _staleTimer;

  AsyncState<Sensor> get state => _state;

  bool get isLoading => _isLoading;

  DateTime? get lastSuccessfulAt => _lastSuccessfulAt;

  String get lastSuccessfulRefreshLabel {
    final at = _lastSuccessfulAt;
    if (at == null) {
      return 'Aucune actualisation réussie';
    }

    final hh = at.hour.toString().padLeft(2, '0');
    final mm = at.minute.toString().padLeft(2, '0');
    final ss = at.second.toString().padLeft(2, '0');
    return 'Dernière actualisation réussie : $hh:$mm:$ss';
  }

  bool get hasStaleData {
    final at = _lastSuccessfulAt;
    if (at == null) {
      return false;
    }

    return DateTime.now().difference(at) >= staleAfter;
  }

  List<Sensor> get sensors {
    final state = _state;

    if (state is Content<Sensor>) {
      return state.values;
    }

    return const <Sensor>[];
  }

  int get totalCount => sensors.length;
  int get onlineCount => sensors.where((sensor) => sensor.isOnline).length;
  int get offlineCount => totalCount - onlineCount;

  Sensor sensorById(String id) {
    return sensors.firstWhere((sensor) => sensor.id == id);
  }

  /// Anti-chevauchement : un seul chargement à la fois (logique ViewModel).
  Future<void> load() async {
    if (_isLoading) {
      return;
    }

    _isLoading = true;
    _setState(const Loading<Sensor>());

    try {
      final sensors = await _repository.fetchAll();
      _lastSuccessfulAt = DateTime.now();
      _scheduleStaleCheck();
      _setState(Content<Sensor>(sensors));
    } catch (_) {
      _setState(const Failure<Sensor>('Impossible de charger les capteurs.'));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _scheduleStaleCheck() {
    _staleTimer?.cancel();
    _staleTimer = Timer(staleAfter, notifyListeners);
  }

  void _setState(AsyncState<Sensor> value) {
    _state = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _staleTimer?.cancel();
    super.dispose();
  }
}
