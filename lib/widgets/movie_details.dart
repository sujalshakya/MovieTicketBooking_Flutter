import 'package:filmvibes/review.dart';
import 'package:filmvibes/widgets/review_model.dart';
import 'package:filmvibes/widgets/time_slot.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'info_widget.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  List<ReviewModel> reviews = [];
  late User currentUser;

  @override
  void initState() {
    super.initState();

    currentUser = FirebaseAuth.instance.currentUser!;
  }

  void addReview(String text, String user, String time) {
    final userEmail = user ?? "Unknown User";
    setState(() {
      reviews.add(ReviewModel(text: text, user: user, time: time));
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController reviewController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Movie Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMovieHeader(),
            const SizedBox(height: 16),
            _buildMovieTitle(),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            _buildMovieDescription(),
            const SizedBox(height: 16),
            _buildReservationButton(context),
            const SizedBox(height: 16),
            _buildReviews(),
            const SizedBox(height: 16),
            TextField(
              controller: reviewController,
              decoration: const InputDecoration(labelText: 'Write a review...'),
            ),
            ElevatedButton(
              onPressed: () {
                String formattedDateTime =
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

                addReview(
                  reviewController.text,
                  currentUser.email ?? "Unknown User",
                  formattedDateTime,
                );
                reviewController.clear();
              },
              child: const Text('Submit Review'),
            ), // Display reviews
          ],
        ),
      ),
    );
  }

  Widget _buildReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Reviews",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 12),
        for (var review in reviews)
          Review(
            text: review.text,
            user: review.user,
            time: review.time,
          ),
      ],
    );
  }

  Widget _buildMovieHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            "https://cps-static.rovicorp.com/2/Open/TMDB4/Program/48875731/_derived_jpg_q90_310x470_m0/48875731_Oppenheimer_TPAA_6_1669046351762_2.jpg",
            fit: BoxFit.fitHeight,
            height: 340,
          ),
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoWidget(
                icon: Icons.video_chat_rounded,
                title: "Genre",
                value: "History"),
            SizedBox(height: 20),
            InfoWidget(
                icon: Icons.access_time_rounded,
                title: "Duration",
                value: "3h 00m"),
            SizedBox(height: 20),
            InfoWidget(
                icon: Icons.star_rate_sharp, title: "Rating", value: "4.5"),
          ],
        ),
      ],
    );
  }

  Widget _buildMovieTitle() {
    return const Text(
      "Oppenheimer",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildMovieDescription() {
    return const Text(
      "The story of American scientist, J. Robert Oppenheimer, and his role in the development of the atomic bomb.",
      style: TextStyle(fontSize: 16, color: Colors.white),
    );
  }

  Widget _buildReservationButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TimeSlotScreen(
                timeSlots: [
                  '7:00 AM',
                  '10:00 AM',
                  '1:00 PM',
                  '4:00 PM',
                  '7:00 PM'
                ],
              ),
            ),
          );
        },
        child: const Text("Book Movie"),
      ),
    );
  }
}
