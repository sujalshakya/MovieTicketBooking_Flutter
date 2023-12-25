import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserData extends StatelessWidget {
  final String documentId;
  GetUserData({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          DateTime timestamp = data['timestamp'].toDate();
          String formattedTimestamp =
              "${timestamp.day}-${timestamp.month}-${timestamp.year} ${timestamp.hour}:${timestamp.minute}";

          return Text('Booked Movie: ${data['movieName']}' +
              '\nUser:  ${data['user']}' +
              '\nTime of Booking: $formattedTimestamp');
        }
        return Text('loading...');
      }),
    );
  }
}
