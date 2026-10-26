import 'package:flutter/material.dart';

import '../models/sensor.dart';

class SensorCard extends StatelessWidget {
  const SensorCard({required this.sensor, required this.onTap, super.key});

  final Sensor sensor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = sensor.isOnline ? Colors.teal : Colors.orange;
    final statusLabel = sensor.isOnline ? 'En ligne' : 'Hors ligne';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: statusColor.withValues(alpha: 0.06),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: statusColor.withValues(alpha: 0.14),
          child: Icon(
            sensor.isOnline ? Icons.sensors : Icons.sensors_off,
            color: statusColor,
          ),
        ),
        title: Text(
          sensor.name,
          style: TextStyle(
            color: sensor.isOnline ? null : Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('📍 ${sensor.location}'),
            Text('Batterie : ${sensor.batteryLevel}% · ${sensor.lastUpdated}'),
            Text(statusLabel, style: TextStyle(color: statusColor)),
          ],
        ),
        trailing: Text(
          '${sensor.value} ${sensor.unit}',
          style: TextStyle(
            color: statusColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
