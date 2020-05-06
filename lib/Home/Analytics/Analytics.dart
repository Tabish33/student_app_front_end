import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:student_app/Helpers/DbProxy.dart';
import 'package:student_app/Helpers/UIHelper.dart';

class Analytics extends StatefulWidget {
  Analytics({Key key}) : super(key: key);

  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  List<String> subjects = ['Math','Science','Social Science','English'];
  List<String> schools = ['Tyndale Biscoe School','Burn Hall School','Presentation Convent School','Delhi Public School'];
  String selected_subject = 'Math';
  String selected_school = 'Tyndale Biscoe School';
  List top_ten_students_across_all_schools = [];
  List top_ten_students_across_school = [];
  List top_ten_schools = [];
  List top_ten_schools_in_subject = [];
  List top_ten_students_in_subject_across_all_schools = [];
  List top_ten_students_in_subject_across_school = [];

  @override
  Widget build(BuildContext context) => AnalyticsView(this);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStats();
  }

  fetchStats(){
    fetchTopTenStudentsAcrossAllSchools();
    fetchTopTenStudentsAcrossSchool();
    fetchTopTenSchools();
    fetchTopTenSchoolsInSubject();
    fetchTopTenStudentsInSubjectAcrossAllSchools();
    fetchTopTenStudentsInSubjectAcrossSchool();
  }

  fetchTopTenStudentsAcrossAllSchools()async{
   Response res = await DbProxy.getData("analytics/top-ten/students/all");
   setState(() {
     top_ten_students_across_all_schools = json.decode(res.body);
   });
  }

  fetchTopTenStudentsAcrossSchool()async{
    Response res = await DbProxy.getData("analytics/top-ten/students/$selected_school/yearly");
   setState(() {
     top_ten_students_across_school = json.decode(res.body);
   });
  }

  fetchTopTenSchools()async{
   Response res = await DbProxy.getData("analytics/top-ten/schools/all");
   setState(() {
     top_ten_schools = json.decode(res.body);
   });
  }

  fetchTopTenSchoolsInSubject()async{
    Response res = await DbProxy.getData("analytics/top-ten/schools/$selected_subject/yearly");
   setState(() {
     top_ten_schools_in_subject = json.decode(res.body);
   });
  }

  fetchTopTenStudentsInSubjectAcrossAllSchools()async{
   Response res = await DbProxy.getData("analytics/top-ten/subject/all/$selected_subject/yearly");
   setState(() {
     top_ten_students_in_subject_across_all_schools = json.decode(res.body);
   });
  }

  fetchTopTenStudentsInSubjectAcrossSchool()async{
   Response res = await DbProxy.getData("analytics/top-ten/subject/$selected_school/$selected_subject/yearly");
   setState(() {
     top_ten_students_in_subject_across_school = json.decode(res.body);
   });
  }
}

class AnalyticsView extends StatelessWidget {
  final _AnalyticsState state;

  const AnalyticsView(this.state,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(18.0),
          child: ListView(
            children: <Widget>[
              showTopTenStudentsAcrossAllSchools(),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
              showTopTenStudentsAcrossSchool(),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
              showTopTenSchools(),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
              showTopTenSchoolsInSubject(),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
              showTopTenStudentsInSubjectAcrossAllSchools(),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
              showTopTenStudentsInSubjectAcrossSchool(),
            ],
          ),
        ),
    );
  }

  showTopTenStudentsAcrossAllSchools(){
    return  Column(
        // shrinkWrap: true,
        children: buildStudentList(state.top_ten_students_across_all_schools,"Top 10 Students")
      
    );
  }

  showTopTenStudentsAcrossSchool(){
    Widget drop_down_button = DropdownButton(
      items: buildDropDownItems(state.schools),
      onChanged: (val){
        state.selected_school = val;
        state.fetchTopTenStudentsAcrossSchool();
      },
      value: state.selected_school,
    );

    return  Column(
        children: buildStudentList(
          state.top_ten_students_across_school,
          "Top 10 Students Across School",
          select_menu: drop_down_button
        )
    );
  }

  showTopTenSchools(){
    return  Column(
        children: buildSchoolList(state.top_ten_schools, "Top 10 Schools" )
    );
  }

  showTopTenSchoolsInSubject(){
    Widget drop_down_button = DropdownButton(
      items: buildDropDownItems(state.subjects),
      onChanged: (val){
        state.selected_subject = val;
        state.fetchTopTenSchoolsInSubject();
      },
      value: state.selected_subject,
    );

    return  Column(
        children: buildSchoolList(
          state.top_ten_schools_in_subject,
          "Top 10 Schools In A Subject",
          select_menu: drop_down_button
        )
    );
  }

  showTopTenStudentsInSubjectAcrossAllSchools(){
    Widget drop_down_button = DropdownButton(
      items: buildDropDownItems(state.subjects),
      onChanged: (val){
        state.selected_subject = val;
        state.fetchTopTenStudentsInSubjectAcrossAllSchools();
      },
      value: state.selected_subject,
    );

    return  Column(
        children: buildStudentList(
          state.top_ten_students_in_subject_across_all_schools,
          "Top 10 Students Across Subject - All Schools",
          select_menu: drop_down_button
        )
    );
  }

  showTopTenStudentsInSubjectAcrossSchool(){
    Widget drop_down_buttons = Column(
      children: [
        DropdownButton(
          items: buildDropDownItems(state.schools),
          onChanged: (val){
            state.selected_school = val;
            state.fetchTopTenStudentsInSubjectAcrossSchool();
          },
          value: state.selected_school,
        ),

        DropdownButton(
          items: buildDropDownItems(state.subjects),
          onChanged: (val){
            state.selected_subject = val;
            state.fetchTopTenStudentsInSubjectAcrossSchool();
          },
          value: state.selected_subject,
        ),
      ],
    );

    return  Column(
        children: buildStudentList(
          state.top_ten_students_in_subject_across_school,
          "Top 10 Students Across Subject",
          select_menu: drop_down_buttons
        )
    );
  } 

  buildStudentList(List list , String title, { Widget select_menu = null}){
    List<Widget> items =  [ buildTitle(title), Padding(padding: EdgeInsets.symmetric(vertical: 7.0)),];

    if(select_menu != null) items.add(select_menu);

    list.forEach((item) { 
      items.add(  
        Container(
          margin: EdgeInsets.only(top:5.0),
          child: Card(
            elevation: 4.0,
            shape: UIHelper.buildRoundedRectangleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      UIHelper.buildText(item['name'],color: Colors.green, weight: FontWeight.w700,size:17.0),
                      UIHelper.buildText("${item['score']}",color: Colors.black54, weight: FontWeight.w700)
                    ],
                  ),

                  UIHelper.buildText(item['school'],color: Colors.black54, weight: FontWeight.w700),
                ],
              ),
            ),
          ),
        )
      );
    });

    return items;
  }

  buildSchoolList(List list , String title, { Widget select_menu = null}){
    List<Widget> items =  [ buildTitle(title),Padding(padding: EdgeInsets.symmetric(vertical: 7.0)),];

    if(select_menu != null) items.add(select_menu);

    list.forEach((item) { 
      items.add(  
        Container(
          margin: EdgeInsets.only(top:5.0),
          child: Card(
            elevation: 4.0,
            shape: UIHelper.buildRoundedRectangleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  UIHelper.buildText(item['_id'],color: Colors.green, weight: FontWeight.w700,size:17.0),
                  UIHelper.buildText("${item['avg_points']}",color: Colors.black54, weight: FontWeight.w700)
                ],
              ),
            ),
          ),
        )
      );
    });

    return items;
  }

  buildTitle(String title){
    return Container(
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child:  UIHelper.buildText(title,color: Colors.white, weight: FontWeight.w700, size: 18.0) ,
    );
  }

  buildDropDownItems(List list){
    List<DropdownMenuItem<String>> items = [];
    list.forEach((item) {
      items.add(
        DropdownMenuItem(child: UIHelper.buildText(item), value: item),
      );
    });
    return items;
  }  
}