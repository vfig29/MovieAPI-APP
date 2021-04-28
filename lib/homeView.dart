import 'package:desafiomovieapi/MovieAPI/Movie.dart';
import 'package:desafiomovieapi/homeController.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text("teste")),
      body: MovieList(),
    ));
  }
}

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final HomeController controller = new HomeController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: Text("teste"),
          onPressed: () => setState(() {
            controller.loadUpcomingMovies();
          }),
        ),
        FutureBuilder<UpcomingMovies>(
            future: controller.loadedMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                return Container(child: Text(snapshot.data.movies[0].image));
              } else {
                return Container(child: Text("nada"));
              }
            }),
      ],
    );
  }
}

class MovieCard extends StatefulWidget {
  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
