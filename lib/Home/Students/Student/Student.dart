import 'package:flutter/material.dart';
import '../../../Helpers/UIHelper.dart';

class Student extends StatefulWidget {
  Map student = {};

  Student(this.student,{Key key}) : super(key: key);

  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  @override
  Widget build(BuildContext context)=> StudentView(this);
}

class StudentView extends StatelessWidget {
  final _StudentState state;

  const StudentView(this.state,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7.0),
       child: Card(
         elevation: 7.0,
         shape: UIHelper.buildRoundedRectangleBorder(),
         child: Padding(
           padding: const EdgeInsets.all(18.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               UIHelper.buildText(state.widget.student['name'], color: Colors.green, weight: FontWeight.w700, size: 18.0),
               Padding(padding: EdgeInsets.only(top:3.0)),
               UIHelper.buildText(state.widget.student['school'], color: Colors.black54, weight: FontWeight.w700 ),
               Padding(padding: EdgeInsets.only(top:5.0)),
               Divider(),
               buildMarksTable(),
              //  Padding(padding: EdgeInsets.only(top:5.0)),
              //  Divider(),
              //  buildOptions()
             ],
           ),
         ),
       ),
    );
  }

  buildMarksTable(){

    return Container(
      margin: EdgeInsets.only(top:5.0),
      child: Table(
        children: getRows(),
      ),
    );
  }

  getRows(){
     List<TableRow> rows = [
       buildTableTitles(),
    ];
     buildSubjectFields(rows);
     return rows;
  }

   buildTableTitles(){
    return TableRow(
      children: [
        TableCell(
          child:UIHelper.buildText("Subject", color: Colors.black54, weight: FontWeight.w700)
        ),
        TableCell(
          child:Center(
            child: UIHelper.buildText("Quarterly", color: Colors.black54, weight: FontWeight.w700),
          )
        ),
        TableCell(
          child:Center(
            child: UIHelper.buildText("Yearly", color: Colors.black54, weight: FontWeight.w700),
          )
        ),
      ]
    );
  }

  List<TableRow> buildSubjectFields(List<TableRow> rows){
    List subjects = state.widget.student['subjects'];
    subjects.forEach((subject) { 
      rows.add(
       TableRow(
          children: [
            TableCell(
              child:UIHelper.buildText("${subject['subject']}", color: Colors.black54, weight: FontWeight.w700)
            ),
            TableCell(
              child:Center(
                child: UIHelper.buildText("${subject['quartely']}", color: Colors.black54, weight: FontWeight.w700),
              )
            ),
            TableCell(
              child:Center(
                child: UIHelper.buildText("${subject['yearly']}", color: Colors.black54, weight: FontWeight.w700),
              )
            ),
          ]
        )
      );
    });
  }

  buildOptions(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        UIHelper.buildIconButton(Icon(Icons.edit),  (){},),
        UIHelper.buildIconButton(Icon(Icons.delete),  (){},)
      ],
    );
  }
}