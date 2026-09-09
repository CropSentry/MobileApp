class SensorData {
  final String id;
  final String ownerId;
  final String deviceName;
  final double soilMoisture;
  final double temperature;
  final DateTime timestamp;

  SensorData({
    required this.id,
    required this.ownerId,
    required this.deviceName,
    required this.soilMoisture,
    required this.temperature,
    required this.timestamp,
  });

  factory SensorData.fromMap(Map<String, dynamic> map, String docId) {
    return SensorData(
      id: docId,
      ownerId: map['ownerId'] ?? '',
      deviceName: map['deviceName'] ?? 'Unknown Field',
      soilMoisture: (map['soilMoisture'] ?? 0.0).toDouble(),
      temperature: (map['temperature'] ?? 0.0).toDouble(),
      timestamp: map['timestamp'] != null
          ? map['timestamp'].toDate()
          : DateTime.now(),
    );
  }
}
