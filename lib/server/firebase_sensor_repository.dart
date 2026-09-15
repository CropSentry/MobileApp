import 'package:cloud_firestore/cloud_firestore.dart';
import 'sensor_repository.dart';
import 'sensor_data.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseSensorRepository implements SensorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
    databaseId: 'cropsentry',
  );
  @override
  Stream<List<SensorData>> getSensorStream(String uid) {
    // Target the specific document using the UID
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('sensors')
        .snapshots()
        .map((querySnapshot) {
          // Map through all sensor documents in the subcollection
          return querySnapshot.docs.map((doc) {
            // Assuming your fromJson factory takes a Map and an ID string
            return SensorData.fromJson(doc.data(), doc.id);
          }).toList();
        });
  }
}
