import 'package:desafiomovieapi/AppCommonWidgets.dart';
import 'package:desafiomovieapi/MovieAPI/MovieData.dart';
import 'package:desafiomovieapi/MovieDetailScene/MovieDetailViewModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieDetailParameters {
  final Movie passedMovie;

  MovieDetailParameters({this.passedMovie});
}

class MovieDetailView extends StatelessWidget {
  final MovieViewModel viewModel = MovieViewModel();
  @override
  Widget build(BuildContext context) {
    final MovieDetailParameters myMovie =
        ModalRoute.of(context).settings.arguments as MovieDetailParameters;
    if (myMovie == null) {
      Navigator.pop(context);
    }
    //
    List<String> formattedDate = DateFormat('dd/MM,yyyy')
        .format(DateTime.parse(myMovie.passedMovie.releaseDate))
        .split(',');
    //
    return AppBackGround(
      body: Container(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.075,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.appGreen, width: 2),
                        color: Colors.black),
                    child: Center(
                        child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: myMovie.passedMovie.title,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.005,
                        bottom: MediaQuery.of(context).size.height * 0.005),
                    //color: Colors.blue,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RowBox(
                          child: Center(
                              child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: formattedDate[0],
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  TextSpan(
                                      text: '\n' + formattedDate[1],
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          )),
                        ),
                        RowBox(
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: myMovie.passedMovie.voteAverage
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '\n Score',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        RowBox(
                          child: StarButton(
                            passedMovie: myMovie.passedMovie,
                            viewModel: viewModel,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.white, width: 1),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            0, MediaQuery.of(context).size.height * 0.01, 0, 0),
                        height: MediaQuery.of(context).size.height,
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            text: myMovie.passedMovie.overview,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                letterSpacing: 0.4),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                    0.1,
                    0.6,
                    1,
                  ],
                      colors: [
                    Colors.black,
                    AppColors.appGreen,
                    Colors.black,
                  ])),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.all(30),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                      backgroundColor: Colors.blueGrey.withOpacity(0.5),
                    ),
                  )),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: (myMovie.passedMovie.image == Movie.imagePath)
                        ? AssetImage("assets/images/place_holder.png")
                        : NetworkImage(myMovie.passedMovie.image),
                    fit: BoxFit.cover),
              ),
              height: MediaQuery.of(context).size.height * 0.65,
            ),
          ),
        ],
      )),
    );
  }
}

class RowBox extends StatelessWidget {
  final Widget child;

  const RowBox({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.03, 0,
          MediaQuery.of(context).size.width * 0.03, 0),
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.08,
    );
  }
}

class StarButton extends StatefulWidget {
  final Movie passedMovie;
  final MovieViewModel viewModel;
  const StarButton({Key key, this.passedMovie, this.viewModel})
      : super(key: key);
  @override
  _StarButtonState createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> {
  IconData currentStarIcon = Icons.arrow_back;
  @override
  void initState() {
    super.initState();
    widget.viewModel.syncFavMark(myMovie: widget.passedMovie);
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: InkWell(
        onTap: () {
          setState(() {
            widget.viewModel.setFavMark(myMovie: widget.passedMovie);
          });
        },
        child: StreamBuilder<bool>(
          stream: widget.viewModel.currentMovieFavStream.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Icon(
                AppIcons.getFavIcon(snapshot.data),
                size: MediaQuery.of(context).size.height * 0.065,
                color: Colors.white,
              );
            } else {
              return Icon(
                Icons.warning,
                size: MediaQuery.of(context).size.height * 0.065,
                color: Colors.white,
              );
            }
          },
        ),
      ),
    );
  }
}
