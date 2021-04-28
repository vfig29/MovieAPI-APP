import 'package:desafiomovieapi/MovieAPI/Movie.dart';
import 'package:desafiomovieapi/homeModel.dart';

class HomeController {
  final HomeModel model = new HomeModel();

  Future<UpcomingMovies> loadedMovies;

  void loadUpcomingMovies() {
    loadedMovies = model.fetchUpcomingMovies();
  }
}
