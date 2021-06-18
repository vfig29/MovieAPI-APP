import 'package:desafiomovieapi/MovieAPI/Movie.dart';

import '../MovieAPI/APIRequest.dart';

class HomeModel {
  static const String _movieAPIkey = 'a5bc05fb630c9b7fdc560033345fa13e';
  final APIUpcomingRequest apiRequest = new APIUpcomingRequest(_movieAPIkey);

  Future<UpcomingMovies> fetchUpcomingMovies({int loadedPage}) {
    return apiRequest.fetchRequest(entry: loadedPage);
  }
}