import 'package:desafiomovieapi/MovieDetailScene/MovieDetailModel.dart';
import 'package:desafiomovieapi/MovieInternalDatabase/SQLAdapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final MovieDetailModel model = MovieDetailModel();
  (model.storageAdapter as SQLAdapter).initDB();
  test('MODEL: MovieID should be saved in SQLDatabase', () {
    model.saveFavoriteKeyById(1);

    expect(model.checkFavoriteKeyById(1), true);

    model.deleteFavoriteKeyById(1);
  });

  test('ADAPTER: MovieID should be saved in SQLDatabase', () {
    model.storageAdapter.storeMovieFav(2);
  });
  test('MODEL: MovieID should be readed from SQLDatabase', () {
    model.checkFavoriteKeyById(1);
    expect(model.checkFavoriteKeyById(2), false);
  });

  test('ADAPTER: MovieID should be readed from SQLDatabase', () {
    model.storageAdapter.getMovieFavById(2);
    model.storageAdapter.getAllMovieFav();
  });

  test('MODEL: MovieID should be deleted from SQLDatabase', () {
    model.deleteFavoriteKeyById(1);
    model.deleteFavoriteKeyById(3);
    expect(model.checkFavoriteKeyById(1), false);
  });

  test('ADAPTER: MovieID should be deleted from SQLDatabase', () {
    model.storageAdapter.removeMovieFav(2);
  });
}
