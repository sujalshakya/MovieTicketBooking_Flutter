import 'package:filmvibes/screens/my_bookings.dart';
import 'package:filmvibes/screens/signin_screen.dart';
import 'package:filmvibes/widgets/movie_carousel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Movie Ticket Booking",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.book_online),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserBookings()));
                }),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()));
                });
              },
            ),
          ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // SearchBar(
            //   hintText: '...',
            //   leading: const Icon(
            //     Icons.search,
            //     color: Color(0xFF282A36),
            //   ),
            //   elevation: MaterialStateProperty.all(0),
            // ),
            const SizedBox(height: 16),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Movies",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: MovieCarousel(),
            ),
          ],
        ),
      ),
    );
  }
}
