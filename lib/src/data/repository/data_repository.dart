import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sec_monitor/src/data/model/monitor_data.dart';
import 'package:sec_monitor/src/firebase_constants.dart';

final class DataRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> syncData(MonitorData data) async {
    final converter = _firestore
        .collection(firestoreUserCollection)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(firestoreDataCollection)
        .withConverter<MonitorData>(
          toFirestore: (data, _) => data.toJson(),
          fromFirestore: (snapshot, _) => MonitorData.fromJson(
            snapshot.data()!,
          ),
        );

    converter.doc(data.timestamp.toString()).set(data);
  }

  Future<void> awaitAllPendingWrites() async {
    await _firestore.waitForPendingWrites();
  }
}
