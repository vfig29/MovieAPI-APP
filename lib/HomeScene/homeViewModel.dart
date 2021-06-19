import 'package:desafiomovieapi/MovieAPI/Movie.dart';
import 'package:desafiomovieapi/HomeScene/homeModel.dart';
import 'package:desafiomovieapi/MovieDetailScene/MovieDetailView.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomeViewModel {
  final HomeModel model = new HomeModel();
  List<UpcomingMovies> cachedPages = [];
  StreamController<List<Movie>> streamLoadedPages = new StreamController();

  void callFirstPage() {
    cachedPages = [];
  }

  void loadUpcomingMovies() {
    if (cachedPages.length < UpcomingMovies.totalPages) {
      model
          .fetchUpcomingMovies(loadedPage: cachedPages.length + 1)
          .then((value) {
        cacheLoadedPage(value);
        streamLoadedPages.add(getPagesMovies());
      });
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

  static void goTomovieDetailScreen(BuildContext context, Movie movie) {
    MovieDetailParameters parameters =
        new MovieDetailParameters(passedMovie: movie);
    Navigator.pushNamed(context, 'MovieDetail', arguments: parameters);
  }
}
