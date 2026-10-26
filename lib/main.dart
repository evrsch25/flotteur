import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/sensor.dart';
import 'repositories/fake_sensor_repository.dart';
import 'states/async_state.dart';
import 'view_models/dashboard_view_model.dart';
import 'widgets/sensor_card.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Démo atelier : 1er appel en échec, réponses lentes (3 s).
  final repository = FakeSensorRepository(remainingFailures: 1);
  final viewModel = DashboardViewModel(repository: repository);

  viewModel.load();

  runApp(MainApp(repository: repository, viewModel: viewModel));
}

class MainApp extends StatelessWidget {
  MainApp({required this.repository, required this.viewModel, super.key});

  final FakeSensorRepository repository;
  final DashboardViewModel viewModel;

  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => DashboardPage(
          repository: repository,
          viewModel: viewModel,
        ),
      ),
      GoRoute(
        path: '/sensor/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final sensor = viewModel.sensorById(id);

          return SensorDetailsPage(sensor: sensor);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.teal.shade50,
      ),
      routerConfig: _router,
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    required this.repository,
    required this.viewModel,
    super.key,
  });

  final FakeSensorRepository repository;
  final DashboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Mes capteurs'),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'fail') {
                    repository.armNextFailure();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Prochaine actualisation en erreur'),
                      ),
                    );
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'fail',
                    child: Text('Démo : forcer la prochaine erreur'),
                  ),
                ],
              ),
              IconButton(
                onPressed: viewModel.isLoading ? null : viewModel.load,
                icon: viewModel.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.refresh),
                tooltip: 'Actualiser',
              ),
            ],
          ),
          body: switch (viewModel.state) {
            Loading() => const Center(child: CircularProgressIndicator()),
            Failure(:final message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message, textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text(
                      viewModel.lastSuccessfulRefreshLabel,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: viewModel.isLoading ? null : viewModel.load,
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              ),
            ),
            Content(values: const []) => const Center(
              child: Text('Aucun capteur'),
            ),
            Content(:final values) => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: values.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _DashboardSummary(viewModel: viewModel);
                }

                if (index == values.length + 1) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Appels FakeRepository : ${repository.fetchCount}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                }

                final sensor = values[index - 1];

                return SensorCard(
                  sensor: sensor,
                  onTap: () => context.push('/sensor/${sensor.id}'),
                );
              },
            ),
          },
        );
      },
    );
  }
}

class SensorDetailsPage extends StatelessWidget {
  const SensorDetailsPage({required this.sensor, super.key});

  final Sensor sensor;

  @override
  Widget build(BuildContext context) {
    final statusColor = sensor.isOnline ? Colors.teal : Colors.orange;
    final statusLabel = sensor.isOnline ? 'En ligne' : 'Hors ligne';

    return Scaffold(
      appBar: AppBar(title: Text(sensor.name)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            elevation: 0,
            color: statusColor.withValues(alpha: 0.10),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    sensor.isOnline ? Icons.sensors : Icons.sensors_off,
                    color: statusColor,
                    size: 44,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${sensor.value} ${sensor.unit}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(statusLabel, style: TextStyle(color: statusColor)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Informations', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: const Text('Emplacement'),
                  subtitle: Text(sensor.location),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.battery_5_bar_outlined),
                  title: const Text('Batterie'),
                  subtitle: Text('${sensor.batteryLevel}%'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.update_outlined),
                  title: const Text('Dernière mise à jour'),
                  subtitle: Text(sensor.lastUpdated),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardSummary extends StatelessWidget {
  const _DashboardSummary({required this.viewModel});

  final DashboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 0,
      color: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vue d’ensemble',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.lastSuccessfulRefreshLabel,
              style: const TextStyle(color: Colors.white70),
            ),
            if (viewModel.hasStaleData) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade700,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Données anciennes — actualisez pour rafraîchir',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SummaryValue(label: 'Capteurs', value: viewModel.totalCount),
                _SummaryValue(label: 'En ligne', value: viewModel.onlineCount),
                _SummaryValue(
                  label: 'Hors ligne',
                  value: viewModel.offlineCount,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryValue extends StatelessWidget {
  const _SummaryValue({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
