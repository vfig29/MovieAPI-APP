import 'package:desafiomovieapi/MovieAPI/MovieData.dart';
import 'package:desafiomovieapi/MovieInternalDatabase/SQLAdapter.dart';
import 'package:desafiomovieapi/MovieInternalDatabase/StorageAdapter.dart';

import '../MovieAPI/APIRequestData.dart';

class HomeModel {
  static const String _movieAPIkey = 'a5bc05fb630c9b7fdc560033345fa13e';
  final APIRequest apiUpcomingRequest = new APIUpcomingRequest(_movieAPIkey);
  final StorageAdapter storageAdapter = SQLAdapter();

  Future<UpcomingMovies> fetchUpcomingMovies({int loadedPage}) {
    return apiUpcomingRequest.fetchRequest(entry: loadedPage);
  }

  Future<List<int>> getAllFavoriteIdsFromDB() async {
    var result = await storageAdapter.getAllMovieFav();
    return result.map((e) {
      print(e['id'].toString());
      return e['id'] as int;
    }).toList();
  }
}
