import 'package:cloud_firestore/cloud_firestore.dart';
import 'sensor_repository.dart';
import 'sensor_data.dart';

class FirebaseSensorRepository implements SensorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<SensorData>> getSensorStream(String uid) {
    // Target the specific document using the UID
    return _firestore.collection('testSentries1').doc(uid).snapshots().map((
      docSnapshot,
    ) {
      // If the user's document exists, return it inside a list
      if (docSnapshot.exists && docSnapshot.data() != null) {
        return [SensorData.fromJson(docSnapshot.data()!, docSnapshot.id)];
      }

      // If no data exists yet for this user, return an empty list
      return [];
    });
  }
}
