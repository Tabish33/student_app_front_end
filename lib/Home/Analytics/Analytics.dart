import 'package:flutter/material.dart';

class Analytics extends StatefulWidget {
  Analytics({Key key}) : super(key: key);

  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("analytics"),
    );
  }
}