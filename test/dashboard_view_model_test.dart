import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/models/sensor.dart';
import 'package:flutter_application_1/repositories/fake_sensor_repository.dart';
import 'package:flutter_application_1/states/async_state.dart';
import 'package:flutter_application_1/view_models/dashboard_view_model.dart';

void main() {
  test('le ViewModel notifie le chargement puis le contenu', () async {
    final viewModel = DashboardViewModel(
      repository: FakeSensorRepository(delay: Duration.zero),
    );
    final observedStates = <AsyncState<Sensor>>[];

    viewModel.addListener(() {
      observedStates.add(viewModel.state);
    });

    await viewModel.load();

    expect(observedStates.first, isA<Loading<Sensor>>());
    expect(observedStates.last, isA<Content<Sensor>>());

    viewModel.dispose();
  });

  test('le ViewModel notifie une erreur', () async {
    final viewModel = DashboardViewModel(
      repository: FakeSensorRepository(
        delay: Duration.zero,
        remainingFailures: 1,
      ),
    );
    final observedStates = <AsyncState<Sensor>>[];

    viewModel.addListener(() {
      observedStates.add(viewModel.state);
    });

    await viewModel.load();

    expect(observedStates.first, isA<Loading<Sensor>>());
    expect(observedStates.last, isA<Failure<Sensor>>());
    expect(viewModel.lastSuccessfulRefreshLabel, 'Aucune actualisation réussie');

    viewModel.dispose();
  });

  test('retry après échec puis succès sur la même instance', () async {
    final repository = FakeSensorRepository(
      delay: Duration.zero,
      remainingFailures: 1,
    );
    final viewModel = DashboardViewModel(repository: repository);

    await viewModel.load();
    expect(viewModel.state, isA<Failure<Sensor>>());

    await viewModel.load();
    expect(viewModel.state, isA<Content<Sensor>>());
    expect(viewModel.lastSuccessfulAt, isNotNull);
    expect(repository.fetchCount, 2);

    viewModel.dispose();
  });

  test('les chargements ne se superposent pas', () async {
    final repository = FakeSensorRepository(
      delay: const Duration(milliseconds: 80),
    );
    final viewModel = DashboardViewModel(repository: repository);

    final first = viewModel.load();
    final second = viewModel.load();
    final third = viewModel.load();

    await Future.wait([first, second, third]);

    expect(repository.fetchCount, 1);
    expect(viewModel.state, isA<Content<Sensor>>());

    await viewModel.load();
    expect(repository.fetchCount, 2);

    viewModel.dispose();
  });

  test('une erreur après succès conserve l’heure', () async {
    final repository = FakeSensorRepository(delay: Duration.zero);
    final viewModel = DashboardViewModel(repository: repository);

    await viewModel.load();
    final successAt = viewModel.lastSuccessfulAt;
    expect(successAt, isNotNull);

    repository.armNextFailure();
    await viewModel.load();

    expect(viewModel.state, isA<Failure<Sensor>>());
    expect(viewModel.lastSuccessfulAt, successAt);

    viewModel.dispose();
  });
}
