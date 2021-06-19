import 'package:flutter/material.dart';

abstract class AppColors {
  static Color appGreen = Colors.teal;
}

class AppBackGround extends StatelessWidget {
  final Widget body;
  final String title;
  final AppBar appBar;

  const AppBackGround({Key key, this.body, this.title, this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar, backgroundColor: Colors.black, body: body);
  }
}
