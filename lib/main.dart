import 'package:desafiomovieapi/HomeScene/homeView.dart';
import 'package:desafiomovieapi/MovieDetailScene/MovieDetailView.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(),
        'MovieDetail': (context) => MovieDetailView(),
      },
    );
  }
}
