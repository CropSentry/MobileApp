import 'package:cloud_firestore/cloud_firestore.dart';
import 'sensor_data.dart';

abstract class DataService {
  Stream<List<SensorData>> getUserDevicesStream(String userId);
}

class FirebaseDataService implements DataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<SensorData>> getUserDevicesStream(String userId) {
    return _firestore
        .collection('devices')
        .where('ownerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => SensorData.fromMap(doc.data(), doc.id))
              .toList();
        });
  }
}

DataService currentBackend = FirebaseDataService();
