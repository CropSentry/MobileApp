class SensorData {
  final String id;
  final double temperature;
  final double humidity;
  // Add other fields relevant to CropSentry

  SensorData({
    required this.id,
    required this.temperature,
    required this.humidity,
  });

  // Converts standard JSON (from any server) into your Dart object
  factory SensorData.fromJson(Map<String, dynamic> json, String id) {
    return SensorData(
      id: id,
      temperature: (json['temperature'] ?? 0).toDouble(),
      humidity: (json['humidity'] ?? 0).toDouble(),
    );
  }
}
