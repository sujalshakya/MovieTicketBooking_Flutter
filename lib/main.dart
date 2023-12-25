import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCtH4R25pZG9K4JbEtckA6b_glbpTTcp0o',
      authDomain: 'movieticketbooking-fyp.firebaseapp.com',
      projectId: 'movieticketbooking-fyp',
      storageBucket: 'movieticketbooking-fyp.appspot.com',
      messagingSenderId: '769979665682',
      appId: '1:769979665682:android:3bfd6852c76bf74f3937cb',
    ),
  );
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  runApp(const MyApp());
}
