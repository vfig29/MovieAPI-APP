import 'package:desafiomovieapi/MovieAPI/APIRequestData.dart';

class UpcomingMovies implements APIResponse {
  static int totalPages = 1;
  int page;
  List<Movie> movies;

  UpcomingMovies.fromJSON(Map<String, dynamic> jsonMap) {
    totalPages = jsonMap['total_pages'];
    page = jsonMap['page'];
    List unmappedMovies = jsonMap['results'] as List;
    movies =
        unmappedMovies.map((movieMap) => Movie.fromJSON(movieMap)).toList();
  }
}

class Movie implements APIResponse {
  static const String imagePath = 'https://image.tmdb.org/t/p/w500/';
  int id = -1;
  String title = "";
  String releaseDate = "";
  String image = "";
  String overview = "";
  double voteAverage = 0;

  Movie.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] != null ? int.parse(jsonMap['id'].toString()) : -1;
    title = (jsonMap['title'] ?? (jsonMap['original_title'] ?? ""));
    releaseDate = (jsonMap['release_date'] ?? "");
    image = imagePath + (jsonMap['poster_path'] ?? "");

    voteAverage = jsonMap['vote_average'] != null
        ? double.parse(jsonMap['vote_average'].toString())
        : 0.0;

    overview = ((jsonMap['overview'] ?? "") == "")
        ? "Sem Resumo."
        : jsonMap['overview'];
  }
}
