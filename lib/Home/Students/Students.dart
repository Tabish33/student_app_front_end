import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_app/Helpers/DbProxy.dart';
import 'package:student_app/Home/Students/Student/Student.dart';
import '../../Helpers/UIHelper.dart';

class Students extends StatefulWidget {
  Students({Key key}) : super(key: key);

  @override
  _StudentsState createState() => _StudentsState();
}

// LOGIC
class _StudentsState extends State<Students> {
  ScrollController listScrollController = new ScrollController();
  bool fetching_students = false;
  bool all_students_retreived = false;
  int skip_students = -10;
  List students = [];

  @override
  Widget build(BuildContext context) => StudentsView(this);

  @override
  void initState() { 
    super.initState();
    loadStudents();
    addScrollListener();
  }

  addScrollListener(){
    listScrollController.addListener(() { 
        var triggerFetchMoreSize =
          0.9 * listScrollController.position.maxScrollExtent;

      if (listScrollController.position.pixels >
          triggerFetchMoreSize && !fetching_students && !all_students_retreived ) {
            loadStudents();
      }
    });
  }

  loadStudents()async{
    setState(() {
      fetching_students = true;
    });
  
    skip_students+=10;
    DbProxy.getData("student/get-students/$skip_students").then((value) => {
      updateStudentsList(json.decode(value.body))
    });
  } 

  updateStudentsList(List new_students){
    setState(() {
      students.addAll(new_students);
      fetching_students = false;
    });

    if (new_students.length == 0) {
      all_students_retreived = true;
    }

  }

}

// VIEW
class StudentsView extends StatelessWidget {
  final _StudentsState state;
  const StudentsView(this.state,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  buildBody(){
    int num_students = state.students.length;
    return  ListView.builder(
      controller: state.listScrollController,
      itemCount: num_students,
      itemBuilder: (BuildContext context, int index){
        Map student = state.students[index];
        if (index < num_students -1) {
          return Student(student);
        } else {
          return state.fetching_students ? Center(child: CircularProgressIndicator(),) : UIHelper.buildText("");
        }
      }
    );
  }
}