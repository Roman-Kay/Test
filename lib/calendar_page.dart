import 'package:flutter/material.dart';
import 'package:test/screen_2.dart';

class CalendarPage extends StatelessWidget {
  final Function onNext;

  CalendarPage({this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: FlatButton(
          onPressed: onNext,
          child: Text('Go to next screen'),
          color: Colors.white,
        ),
      ),
    );
  }
}
