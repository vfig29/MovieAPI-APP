import 'dart:async';
import 'package:desafiomovieapi/MovieAPI/MovieData.dart';
import 'package:desafiomovieapi/MovieDetailScene/MovieDetailModel.dart';

class MovieViewModel {
  final MovieDetailModel movieDetailModel = new MovieDetailModel();
  StreamController<bool> currentMovieFavStream = new StreamController();

  void saveMovieAsFavorite(Movie favoriteMovie) {
    movieDetailModel.saveFavoriteKeyById(favoriteMovie.id);
  }

  void deleteMovieFromFavorite(Movie favoriteMovie) {
    movieDetailModel.deleteFavoriteKeyById(favoriteMovie.id);
  }

  Future<bool> checkMovieIsFavorite(Movie favoriteMovie) async {
    return await movieDetailModel.checkFavoriteKeyById(favoriteMovie.id);
  }

  void setFavMark({Movie myMovie}) {
    checkMovieIsFavorite(myMovie)
        .then((value) => {
              value
                  ? deleteMovieFromFavorite(myMovie)
                  : saveMovieAsFavorite(myMovie),
            })
        .then((value) {
      syncFavMark(myMovie: myMovie);
    });
  }

  void syncFavMark({Movie myMovie}) async {
    checkMovieIsFavorite(myMovie).then((value) {
      currentMovieFavStream.add(value);
    });
  }
}
