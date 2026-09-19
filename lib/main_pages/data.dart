import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../server/sensor_repository.dart';
import '../server/sensor_data.dart';

class DataPage extends StatefulWidget {
  final SensorRepository repository;
  final int targetNodeId;
  const DataPage({
    super.key,
    required this.repository,
    required this.targetNodeId,
  });

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    // Retrieve the UID of the currently logged-in user
    final String currentUid = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(title: Text('Data Page - Sentry ${widget.targetNodeId}')),
      body: StreamBuilder<List<SensorData>>(
        stream: widget.repository.getSensorStream(currentUid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found for this account.'));
          }

          final dataList = snapshot.data!;

          // Find the specific sensor data for this page
          final sensor = dataList.firstWhere(
            (s) => s.nodeId == widget.targetNodeId,
            orElse: () => dataList.first, // Fallback
          );
          final avgTemp =
              (((sensor.tempSensor1 + sensor.tempSensor2) / 2) * 100).round() /
              100;
          final avgHumid =
              (((sensor.humidSensor1 + sensor.humidSensor2) / 2) * 100)
                  .round() /
              100;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0, 16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        DisplayBox(
                          title: "Av. TEMPERATURE",
                          info: "$avgTemp°C",
                          icon: Icons.thermostat,
                          iconColor: Colors.deepOrangeAccent,
                        ),
                        DisplayBox(
                          title: "AV. HUMIDITY",
                          info: "$avgHumid%",
                          icon: Icons.water_drop,
                          iconColor: Colors.blueAccent,
                        ),
                        DisplayBox(
                          title: "DISEASE RISK",
                          info: "MODERATE",
                          icon: Icons.warning_amber_rounded,
                          iconColor: Colors.redAccent,
                          extraInfo: "Priority High",
                        ),
                      ],
                    ),
                  ),
                ),
                Text('Sentry ${sensor.nodeId} is online.'),

                // Going to add graphs, date filters, and data widgets below
              ],
            ),
          );
        },
      ),
    );
  }
}

class DisplayBox extends StatelessWidget {
  final String title;
  final String info;
  final IconData icon;
  final Color iconColor;
  final dynamic extraInfo;
  const DisplayBox({
    super.key,
    required this.title,
    required this.info,
    required this.icon,
    required this.iconColor,
    this.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  info,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          if (extraInfo != null) ...[
            const SizedBox(height: 8),
            Text(
              extraInfo!,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ],
      ),
    );
  }
}
