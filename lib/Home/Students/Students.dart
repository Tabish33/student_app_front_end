import 'package:flutter/material.dart';

class Students extends StatefulWidget {
  Students({Key key}) : super(key: key);

  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("students"),
    );
  }
}