import 'package:desafiomovieapi/MovieAPI/Movie.dart';

import 'MovieAPI/APIRequest.dart';

class HomeModel {
  static const String _movieAPIkey = 'a5bc05fb630c9b7fdc560033345fa13e';
  final APIUpcomingRequest apiRequest = new APIUpcomingRequest(_movieAPIkey);
  int loadedPages = 1;

  Future<UpcomingMovies> fetchUpcomingMovies() {
    return apiRequest.fetchRequest(entry: loadedPages);
  }
}
