import 'package:desafiomovieapi/MovieAPI/Movie.dart';
import 'package:desafiomovieapi/MovieDetailScene/MovieDetailModel.dart';

class MovieDetailController {
  final MovieDetailModel movieDetailModel = new MovieDetailModel();

  void saveMovieAsFavorite(Movie favoriteMovie) {
    movieDetailModel.modifyFavoriteKeyById(favoriteMovie.id, true);
  }

  void removeMovieFromFavorite(Movie favoriteMovie) {
    movieDetailModel.modifyFavoriteKeyById(favoriteMovie.id, false);
  }

  bool checkMovieIsFavorite(Movie favoriteMovie) {
    return movieDetailModel.getFavoriteKeyById(favoriteMovie.id);
  }
}
