import 'package:flutter/material.dart';
import '../User Authentication/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../usedWidgets/display_card.dart';
import '../server/sensor_repository.dart';
import '../server/sensor_data.dart';
import 'dart:math';

class HomePage extends StatelessWidget {
  final SensorRepository repository;
  const HomePage({super.key, required this.repository});
  double round(double input, int decimal) {
    return (input * pow(10, decimal)).round() / pow(10, decimal);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = FirebaseAuth.instance.currentUser;
    final emailPrefix = (user != null && user.email != null)
        ? user.email!.split('@').first
        : 'Farmer'; // Fallback text
    final String currentUid = FirebaseAuth.instance.currentUser?.uid ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => AuthService().signOut(),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: StreamBuilder<List<SensorData>>(
        stream: repository.getSensorStream(currentUid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No sentries found for $currentUid.'));
          }
          final dataList = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Welcome $emailPrefix!',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    final sensor = dataList[index];
                    // Pass the raw data directly into your existing, untouched UI components
                    // return DisplayCard(temperature: sensor.temperature, humidity: sensor.humidity);
                    return SentryCard(
                      title: sensor.nodeId,
                      status: "OK",
                      moisture: (round(
                        (sensor.humidSensor1 + sensor.humidSensor2) / 2,
                        2,
                      )),
                      temperature: (round(
                        (sensor.tempSensor1 + sensor.tempSensor2) / 2,
                        2,
                      )),
                      isOnline: true,
                      repository: repository,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
