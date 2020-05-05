import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:student_app/Helpers/DbProxy.dart';
import 'package:student_app/Home/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> schools = ['Tyndale Biscoe School', 'Mallinson School','Burn Hall School', 'Presentation Convent School','Delhi Public School'];
  List<String> subjects = ['Math','English','Science', 'Social Science'];
  List<String> exam_type = ['Quaterly','Yearly'];
  var faker = new Faker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // generateDummyData();
  }

  generateDummyData(){
    for (var i = 0; i < schools.length; i++) {
      for (var l = 0; l < 20; l++) {
        Map<String,dynamic> student = {};
        student['school'] = schools[i];
        student['name'] = faker.person.name();
        student['subjects'] = [];

        for (var k = 0; k < subjects.length; k++) {
          String subject = subjects[k];
          int marks_quaterly = faker.randomGenerator.integer(100, min: 50);
          int marks_yearly = faker.randomGenerator.integer(100, min: 50);

          student['subjects'].add({ "quartely": marks_quaterly, "yearly": marks_yearly, "subject" : "$subject" });
        }

        String body = json.encode(student);
        DbProxy.postData("student/add-student", body);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}
