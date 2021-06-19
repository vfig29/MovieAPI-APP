import 'package:desafiomovieapi/MovieAPI/MovieData.dart';
import 'package:desafiomovieapi/HomeScene/homeModel.dart';
import 'package:desafiomovieapi/MovieDetailScene/MovieDetailView.dart';
import 'package:desafiomovieapi/MovieInternalDatabase/SQLAdapter.dart';
import 'package:desafiomovieapi/MovieInternalDatabase/StorageAdapter.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomeViewModel {
  bool _onlyFavoriteFlag = false;
  bool get favoriteState {
    return _onlyFavoriteFlag;
  }

  final HomeModel model = new HomeModel();
  final StorageAdapter storageAdapter = SQLAdapter();
  List<UpcomingMovies> cachedPages = [];
  StreamController<List<Movie>> streamLoadedPages = new StreamController();

  void callFirstPage() {
    _onlyFavoriteFlag = false;
    cachedPages = [];
  }

  void loadUpcomingMovies() {
    if (cachedPages.length < UpcomingMovies.totalPages && !_onlyFavoriteFlag) {
      model
          .fetchUpcomingMovies(loadedPage: cachedPages.length + 1)
          .then((value) {
        cacheLoadedPage(value);
        streamLoadedPages.add(getPagesMovies());
      });
    }
  }

  void filterFavorite() async {
    _onlyFavoriteFlag = !_onlyFavoriteFlag;
    if (_onlyFavoriteFlag) {
      streamLoadedPages.add(await getPagesFavoriteMovies());
    } else {
      streamLoadedPages.add(getPagesMovies());
    }
  }

  void cacheLoadedPage(UpcomingMovies appendedPages) {
    return cachedPages.add(appendedPages);
  }

  List<Movie> getPagesMovies() {
    List<Movie> moviesList = [];
    cachedPages.forEach((element) {
      moviesList.addAll(element.movies);
    });
    return moviesList;
  }

  Future<List<Movie>> getPagesFavoriteMovies() async {
    List<Movie> moviesList = [];
    List<int> idList = await model.getAllFavoriteIdsFromDB();
    print(idList.length);
    moviesList = getPagesMovies()
        .where((element) => idList.contains(element.id))
        .toList();
    return moviesList;
  }

  static void goTomovieDetailScreen(BuildContext context, Movie movie) {
    MovieDetailParameters parameters =
        new MovieDetailParameters(passedMovie: movie);
    Navigator.pushNamed(context, 'MovieDetail', arguments: parameters);
  }
}
