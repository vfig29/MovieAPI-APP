import 'package:desafiomovieapi/AppCommonWidgets.dart';
import 'package:desafiomovieapi/MovieAPI/Movie.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieDetailParameters {
  final Movie passedMovie;

  MovieDetailParameters({this.passedMovie});
}

class MovieDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MovieDetailParameters myMovie =
        ModalRoute.of(context).settings.arguments as MovieDetailParameters;
    if (myMovie == null) {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    }
    //
    String formattedDate = DateFormat('dd/MM \n yyyy')
        .format(DateTime.parse(myMovie.passedMovie.releaseDate));
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
                        child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: myMovie.passedMovie.title,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.005,
                        bottom: MediaQuery.of(context).size.height * 0.005),
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Row(
                      children: [
                        RowBox(
                          child: Center(
                              child: RichText(
                            text: TextSpan(
                              text: formattedDate,
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          )),
                        ),
                        RowBox(),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white, width: 1),
                          bottom: BorderSide(color: Colors.white, width: 1)),
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            text: myMovie.passedMovie.overview,
                            style: TextStyle(
                                fontSize: 18,
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
                        Navigator.popUntil(context, ModalRoute.withName('/'));
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
      color: Colors.red,
      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.03, 0,
          MediaQuery.of(context).size.width * 0.03, 0),
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.08,
    );
  }
}
