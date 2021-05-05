import 'package:desafiomovieapi/MovieAPI/Movie.dart';
import 'package:desafiomovieapi/homeController.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            child: Container(
              color: Colors.teal,
              height: 4.0,
            ),
            preferredSize: Size.fromHeight(4.0),
          ),
          title: Center(
            child: Container(
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Text("UPCOMING MOVIES"),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black)),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: UpcomingMovieList());
  }
}

class UpcomingMovieList extends StatefulWidget {
  @override
  _UpcomingMovieListState createState() => _UpcomingMovieListState();
}

class _UpcomingMovieListState extends State<UpcomingMovieList> {
  final HomeController controller = new HomeController();

  @override
  void initState() {
    super.initState();
    controller.callFirstPage();
    controller.loadUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 1],
              colors: [Colors.black, Colors.teal])),
      child: FutureBuilder<UpcomingMovies>(
        future: controller.loadedMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.movies.length,
                itemBuilder: (context, index) {
                  return Center(
                      child: MovieCard(
                    title: snapshot.data.movies[index].title,
                    releaseDate: snapshot.data.movies[index].releaseDate,
                    image: snapshot.data.movies[index].image,
                  ));
                });
          } else if (snapshot.hasError) {
            return Text(
              "Um erro não esperado...",
              style: TextStyle(color: Colors.amber),
            );
          } else {
            return Text(
              "Estamos em manutenção",
              style: TextStyle(color: Colors.amber),
            );
          }
        },
      ),
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
      width: 500,
      height: 500,
      margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill)),
      child: Stack(
        children: [
          MovieCardInfo(
            title: title,
            releaseDate: releaseDate,
            alignment: Alignment.bottomLeft,
          )
        ],
      ),
    );
  }
}

class MovieCardInfo extends StatefulWidget {
  final String title;
  final String releaseDate;
  final Alignment alignment;

  const MovieCardInfo({Key key, this.title, this.releaseDate, this.alignment})
      : super(key: key);

  @override
  _MovieCardInfoState createState() => _MovieCardInfoState();
}

class _MovieCardInfoState extends State<MovieCardInfo> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: Container(
        height: 65,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.white, width: 4),
              top: BorderSide(color: Colors.white, width: 1)),
        ),
        child: Stack(children: [
          Opacity(opacity: 0.6, child: Container(color: Colors.black)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: widget.title,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: RichText(
                      text: TextSpan(
                        text: widget.releaseDate,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    )),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
