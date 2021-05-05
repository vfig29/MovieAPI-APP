import 'package:desafiomovieapi/MovieAPI/Movie.dart';
import 'package:desafiomovieapi/homeModel.dart';

class HomeController {
  final HomeModel model = new HomeModel();

  Future<UpcomingMovies> loadedMovies;

  void callNextPage() {
    model.loadedPages++;
  }

  void callFirstPage() {
    model.loadedPages = 1;
  }

  void loadUpcomingMovies() {
    loadedMovies = model.fetchUpcomingMovies();
  }
}
