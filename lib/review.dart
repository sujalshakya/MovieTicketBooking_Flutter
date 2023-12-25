import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const Review({
    Key? key,
    required this.text,
    required this.user,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(text),
          Row(
            children: [
              Text(
                user,
                style: TextStyle(color: Colors.grey[400]),
              ),
              Text(".", style: TextStyle(color: Colors.grey[400])),
              Text(time, style: TextStyle(color: Colors.grey[400])),
            ],
          )
        ]));
  }
}
