import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference timeSlotsCollection =
      FirebaseFirestore.instance.collection('timeSlots');

  Future<void> addTimeSlot(String timeSlot) async {
    await timeSlotsCollection.add({
      'timeSlot': timeSlot,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
