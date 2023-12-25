import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  String name;
  String genre;
  String summary;
  String duration;
  String link;

  Movie(
      {required this.name,
      required this.genre,
      required this.summary,
      required this.duration,
      required this.link});
}

class MovieDatabase {
  static CollectionReference movies =
      FirebaseFirestore.instance.collection('movies');

  static Future<void> saveMovie(Movie movie) async {
    try {
      await movies.add({
        'name': movie.name,
        'genre': movie.genre,
        'summary': movie.summary,
        'duration': movie.duration,
        'link': movie.link
      });
      print('Movie successfully saved to Firestore');
    } catch (e) {
      print('Error saving movie to Firestore: $e');
    }
  }
}
