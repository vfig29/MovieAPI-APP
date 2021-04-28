import 'package:desafiomovieapi/MovieAPI/Movie.dart';
import 'package:desafiomovieapi/homeController.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text("MOVIE: API"),
              ),
              backgroundColor: Colors.cyan,
            ),
            backgroundColor: Colors.deepPurple,
            body: MovieList()));
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
    return FutureBuilder<UpcomingMovies>(
      future: controller.loadedMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          controller.loadUpcomingMovies();
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.movies.length,
              itemBuilder: (context, index) {
                return MovieCard(
                  title: snapshot.data.movies[index].title,
                  releaseDate: snapshot.data.movies[index].releaseDate,
                  image: snapshot.data.movies[index].releaseDate,
                );
              });
        } else {
          return Text("blah");
        }
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String releaseDate;
  final String image;

  const MovieCard({Key key, this.title, this.releaseDate, this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 500,
      width: 50,
      margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: Column(
        children: [Text(title), Text(releaseDate), Text(image)],
      ),
    );
  }
}
