import 'package:filmvibes/admin/movie_database.dart';
import 'package:flutter/material.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key? key}) : super(key: key);

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final TextEditingController _movieNameTextController =
      TextEditingController();
  final TextEditingController _movieGenreTextController =
      TextEditingController();
  final TextEditingController _movieSummaryTextController =
      TextEditingController();
  final TextEditingController _movieDurationTextController =
      TextEditingController();
  final TextEditingController _movieImageTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _movieNameTextController,
              decoration: InputDecoration(labelText: 'Movie Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _movieGenreTextController,
              decoration: InputDecoration(labelText: 'Movie Genre'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _movieSummaryTextController,
              decoration: InputDecoration(labelText: 'Movie Summary'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _movieDurationTextController,
              decoration: InputDecoration(labelText: 'Movie Duration'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _movieImageTextController,
              decoration:
                  InputDecoration(labelText: 'Link to image of Movie Poster'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                String movieName = _movieNameTextController.text;
                String movieGenre = _movieGenreTextController.text;
                String movieSummary = _movieSummaryTextController.text;
                String movieDuration = _movieDurationTextController.text;
                String movieLink = _movieImageTextController.text;

                Movie newMovie = Movie(
                  name: movieName,
                  genre: movieGenre,
                  summary: movieSummary,
                  duration: movieDuration,
                  link: movieLink,
                );

                MovieDatabase.saveMovie(newMovie);

                _clearTextFields();
              },
              child: Text('Add Movie'),
            ),
          ],
        ),
      ),
    );
  }

  void _clearTextFields() {
    _movieNameTextController.clear();
    _movieGenreTextController.clear();
    _movieSummaryTextController.clear();
    _movieDurationTextController.clear();
    _movieImageTextController.clear();
  }
}
