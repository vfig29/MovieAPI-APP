import 'package:desafiomovieapi/AppCommonWidgets.dart';
import 'package:desafiomovieapi/MovieAPI/MovieData.dart';
import 'package:desafiomovieapi/HomeScene/homeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel viewModel = new HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return AppBackGround(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            hoverColor: AppColors.appGreen,
            onPressed: () {
              setState(() {
                viewModel.filterFavorite();
              });
            },
            icon: Icon(
              AppIcons.getFavIcon(viewModel.favoriteState),
              color: Colors.white,
            ),
            iconSize: 42,
          )
        ],
        bottom: PreferredSize(
          child: Container(
            color: AppColors.appGreen,
            height: 4.0,
          ),
          preferredSize: Size.fromHeight(4.0),
        ),
        title: Center(
          child: Container(
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Center(child: Text("LANÇAMENTOS"))),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(5))),
        ),
        backgroundColor: Colors.black,
      ),
      body: UpcomingMovieList(
        viewModel: viewModel,
      ),
      title: "LANÇAMENTOS",
    );
  }
}

class UpcomingMovieList extends StatefulWidget {
  final HomeViewModel viewModel;

  const UpcomingMovieList({Key key, this.viewModel}) : super(key: key);
  @override
  _UpcomingMovieListState createState() => _UpcomingMovieListState();
}

class _UpcomingMovieListState extends State<UpcomingMovieList> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.callFirstPage();
    widget.viewModel.loadUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 1],
              colors: [Colors.black, AppColors.appGreen])),
      child: StreamBuilder<List<Movie>>(
        stream: widget.viewModel.streamLoadedPages.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  if (index == snapshot.data.length - 1) {
                    widget.viewModel.loadUpcomingMovies();
                  }
                  return Center(
                      child: MovieCard(
                    myMovie: snapshot.data[index],
                  ));
                });
          } else if (snapshot.hasError) {
            return ErrorText(
              text: "Um erro não esperado...",
            );
          } else {
            return ErrorText(
              text: "Estamos em manutenção",
            );
          }
        },
      ),
    );
  }
}

class ErrorText extends StatelessWidget {
  final String text;
  const ErrorText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.amber),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie myMovie;

  const MovieCard({Key key, this.myMovie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 500,
        height: 500,
        margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: (myMovie.image == Movie.imagePath)
                  ? AssetImage("assets/images/place_holder.png")
                  : NetworkImage(myMovie.image),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            MovieCardInfo(
              title: myMovie.title,
              releaseDate: myMovie.releaseDate,
              alignment: Alignment.bottomLeft,
            )
          ],
        ),
      ),
      onTap: () => HomeViewModel.goTomovieDetailScreen(context, myMovie),
    );
  }
}

class MovieCardInfo extends StatelessWidget {
  final String title;
  final String releaseDate;
  final Alignment alignment;

  const MovieCardInfo({Key key, this.title, this.releaseDate, this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(releaseDate));
    return Align(
      alignment: alignment,
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
                        text: title,
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
                        text: formattedDate,
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
