import 'package:filmvibes/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'cinema_screen_painter.dart';
import 'cinema_seat.dart';
import 'legend_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookCinemaScreen extends StatefulWidget {
  const BookCinemaScreen({Key? key}) : super(key: key);

  @override
  _BookCinemaScreenState createState() => _BookCinemaScreenState();
}

class _BookCinemaScreenState extends State<BookCinemaScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime timestamp = DateTime.now();
  double totalPrice = 00.0;
  late User currentUser;

  @override
  void initState() {
    super.initState();

    currentUser = FirebaseAuth.instance.currentUser!;
  }

  List<List<bool>> seatAvailability = [
    [true, true, true, true, true],
    [true, true, true, true, true],
    [true, true, true, true, true],
    [true, true, true, true, true],
    [true, true, true, true, true],
  ];

  List<List<bool>> seatSelection = List.generate(
    5,
    (_) => List.filled(5, false),
  );

  void updateTotalPrice() {
    double price = 0.0;
    for (int row = 0; row < seatSelection.length; row++) {
      for (int col = 0; col < seatSelection[row].length; col++) {
        if (seatSelection[row][col]) {
          price += 200.0;
        }
      }
    }
    setState(() {
      totalPrice = price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oppenheimer'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCinemaScreen(),
          _buildScreenInfo(),
          _buildSeatGrid(),
          _buildLegend(),
          _buildTotalAndBuyButton(),
        ],
      ),
    );
  }

  Widget _buildCinemaScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 100),
          painter: CinemaScreenPainter(),
        ),
      ),
    );
  }

  Widget _buildScreenInfo() {
    return const Column(
      children: [
        Center(
          child: Text(
            "MOVIE",
            style:
                TextStyle(color: Color.fromARGB(255, 27, 26, 27), fontSize: 20),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSeatGrid() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: seatAvailability[0].length,
            crossAxisSpacing: 20,
            mainAxisSpacing: 15,
          ),
          itemCount: seatAvailability.length * seatAvailability[0].length,
          itemBuilder: (context, index) {
            final row = index ~/ seatAvailability[0].length;
            final col = index % seatAvailability[0].length;

            return CinemaSeat(
              isAvailable: seatAvailability[row][col],
              isSelected: seatSelection[row][col],
              onTap: () {
                setState(() {
                  seatSelection[row][col] = !seatSelection[row][col];
                });
                updateTotalPrice();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LegendItem(color: Colors.green.withOpacity(0.6), text: "Available"),
          const LegendItem(color: Colors.red, text: "Selected"),
          const LegendItem(color: Color(0xFF44475A), text: "Reserved"),
        ],
      ),
    );
  }

  Widget _buildTotalAndBuyButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: Rs. ${(totalPrice).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              _showBuyDialog(context, currentUser);
            },
            child: const Text('Buy'),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalScrollableRow(Widget Function(int) itemBuilder) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = -3; i <= 3; i++) itemBuilder(i),
        ],
      ),
    );
  }
}

void _showBuyDialog(BuildContext context, User currentUser) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to buy?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookCinemaScreen(),
                ),
              );
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              addBookingDetails("Oppenheimer", Timestamp.now(),
                  currentUser.email!, currentUser.uid);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            child: Text('Confirm'),
          ),
        ],
      );
    },
  );
}

Future addBookingDetails(
    String movieName, Timestamp timestamp, String email, String uid) async {
  await FirebaseFirestore.instance.collection('users').add({
    'movieName': "Oppenheimer",
    'timestamp': timestamp,
    'user': email,
    'uid': uid,
  });
}
