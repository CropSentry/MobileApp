import 'dart:math';

class SensorData {
  final DateTime Date;
  final double humidSensor1;
  final double humidSensor2;
  final double nOxide_vocSensor;
  final int nodeId;
  final int samples;
  final int sequenceNumber;
  final double soilSensor;
  final double tempSensor1;
  final double tempSensor2;
  final bool validityBool;
  final double vocSensor1;
  final double vocSensor2;
  // Add other fields relevant to CropSentry

  SensorData({
    required this.Date,
    required this.humidSensor1,
    required this.humidSensor2,
    required this.nOxide_vocSensor,
    required this.nodeId,
    required this.samples,
    required this.sequenceNumber,
    required this.soilSensor,
    required this.tempSensor1,
    required this.tempSensor2,
    required this.validityBool,
    required this.vocSensor1,
    required this.vocSensor2,
  });

  // Converts standard JSON (from any server) into your Dart object
  factory SensorData.fromJson(Map<String, dynamic> json, String id) {
    double round(double input, int decimal) {
      return (input * pow(10, decimal)).round() / pow(10, decimal);
    }

    return SensorData(
      Date: (json["Date"] ?? "Unknown").toDate(),
      humidSensor1: round((json['humidSensor1'] ?? 0).toDouble(), 2),
      humidSensor2: round((json['humidSensor2'] ?? 0).toDouble(), 2),
      nOxide_vocSensor: round((json['nOxide_vocSensor'] ?? 0).toDouble(), 2),
      nodeId: (json['nodeId'] ?? 0).toInt(),
      samples: (json['samples'] ?? 0).toInt(),
      sequenceNumber: (json['sequenceNumber'] ?? 0).toInt(),
      soilSensor: round((json['soilSensor'] ?? 0).toDouble(), 2),
      tempSensor1: round((json['tempSensor1'] ?? 0).toDouble(), 2),
      tempSensor2: round((json['tempSensor2'] ?? 0).toDouble(), 2),
      validityBool: (json['validityBool'] ?? 0),
      vocSensor1: round((json['vocSensor1'] ?? 0).toDouble(), 2),
      vocSensor2: round((json['vocSensor2'] ?? 0).toDouble(), 2),
    );
  }
}
