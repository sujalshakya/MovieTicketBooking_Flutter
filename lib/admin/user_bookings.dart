import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmvibes/read_data/get_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AllBookings extends StatefulWidget {
  const AllBookings({Key? key});

  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('users').get();
      snapshot.docs.forEach((document) {
        docIDs.add(document.reference.id);
      });

      setState(() {});
    } catch (error) {
      print("Error fetching data: $error");
      setState(() {});
    }
  }

  Future<void> deletedata(int index) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(docIDs[index])
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Bookings"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GetUserData(documentId: docIDs[index]),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => _showBuyDialog(context, index),
                            child: Text("Delete Booking"),
                          ),
                        ],
                      ),
                      tileColor: Colors.black45,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBuyDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to Cancel Booking?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                deletedata(index);
                setState(() {
                  docIDs.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
