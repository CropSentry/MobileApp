import 'package:flutter/material.dart';
import 'theme.dart';

class SentryCard extends StatelessWidget {
  final String title;
  final String status;
  final double moisture;
  final double temperature;
  final bool isOnline;

  const SentryCard({
    super.key,
    required this.title,
    required this.status,
    required this.moisture,
    required this.temperature,
    required this.isOnline,
  });

  Color _getCardColor() {
    switch (status) {
      case 'OK':
        return AppTheme.statusOk;
      case 'Alert':
        return AppTheme.statusAlert;
      case 'Danger':
        return AppTheme.statusDanger;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: _getCardColor(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isOnline ? Icons.wifi : Icons.wifi_off,
                  color: isOnline ? Colors.white : Colors.black,
                  size: 30,
                ),
                SizedBox(width: 16),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.thermostat,
                    color: theme.colorScheme.error,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Moisture: $moisture',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.water_drop,
                    color: theme.colorScheme.secondary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Temp: $temperature°C',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
