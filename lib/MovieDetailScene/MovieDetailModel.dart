import 'package:desafiomovieapi/MovieInternalDatabase/SQLAdapter.dart';
import 'package:desafiomovieapi/MovieInternalDatabase/StorageAdapter.dart';

class MovieDetailModel {
  final StorageAdapter storageAdapter = new SQLAdapter();

  void saveFavoriteKeyById(int movieId) {
    storageAdapter.storeMovieFav(movieId);
  }

  void deleteFavoriteKeyById(int movieId) {
    storageAdapter.removeMovieFav(movieId);
  }

  Future<bool> checkFavoriteKeyById(int movieId) async {
    List<Map<String, dynamic>> result =
        await storageAdapter.getMovieFavById(movieId);
    return (result.length > 0);
  }
}
