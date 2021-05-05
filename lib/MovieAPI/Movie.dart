import 'package:desafiomovieapi/MovieAPI/APIrequest.dart';

abstract class APIResponse {
  APIResponse.fromJSON(Map<String, dynamic> jsonMap);
}

class UpcomingMovies implements APIResponse {
  int page;
  List<Movie> movies;

  UpcomingMovies.fromJSON(Map<String, dynamic> jsonMap) {
    page = jsonMap['page'];
    List unmappedMovies = jsonMap['results'] as List;
    movies =
        unmappedMovies.map((movieMap) => Movie.fromJSON(movieMap)).toList();
  }
}

class Movie implements APIResponse {
  static const String imagePath = 'https://image.tmdb.org/t/p/w500/';
  String title;
  String releaseDate;
  String image;

  Movie.fromJSON(Map<String, dynamic> jsonMap) {
    title = jsonMap['original_title'];
    releaseDate = jsonMap['release_date'];
    image = imagePath + jsonMap['poster_path'];
  }
}
