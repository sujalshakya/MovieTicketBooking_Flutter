import 'package:filmvibes/widgets/cinema/book_cinema_screen.dart';
import 'package:flutter/material.dart';

class TimeSlotScreen extends StatelessWidget {
  const TimeSlotScreen({Key? key, required this.timeSlots}) : super(key: key);

  final List<String> timeSlots;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Time Slot'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Available Time Slots',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            for (var timeSlot in timeSlots)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToTimeSlotDetails(context, timeSlot);
                  },
                  child: Text(timeSlot),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _navigateToTimeSlotDetails(BuildContext context, String timeSlot) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BookCinemaScreen(),
      ),
    );
  }
}

class TimeSlotDetailsScreen extends StatelessWidget {
  const TimeSlotDetailsScreen({Key? key, required this.timeSlot})
      : super(key: key);

  final String timeSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Slot Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Selected Time Slot',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            // Display the selected time slot
            Center(
              child: Text(
                timeSlot,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
