abstract class StorageAdapter {
  void storeMovieFav(int movieId);

  void removeMovieFav(int movieId);

  Future<List<Map<String, dynamic>>> getAllMovieFav();

  Future<List<Map<String, dynamic>>> getMovieFavById(int movieId);
}
