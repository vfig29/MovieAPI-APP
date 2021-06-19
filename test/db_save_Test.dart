import 'package:desafiomovieapi/MovieDetailScene/MovieDetailModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MovieID should be saved in SQLDatabase', () {
    final MovieDetailModel model = MovieDetailModel();

    model.saveFavoriteKeyById(1);

    expect(model.checkFavoriteKeyById(1), true);

    model.deleteFavoriteKeyById(1);
  });
}
