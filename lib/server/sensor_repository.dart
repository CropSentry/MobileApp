import 'sensor_data.dart';

abstract class SensorRepository {
  // A Stream automatically pushes real-time updates to the UI
  Stream<List<SensorData>> getSensorStream(String uid);
}
