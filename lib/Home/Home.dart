import 'package:flutter/material.dart';
import 'package:student_app/Home/Analytics/Analytics.dart';
import 'package:student_app/Home/Students/Students.dart';
// import 'package:student_app/Home/HomeView.dart';
import '../Helpers/UIHelper.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

// BUSINESS LOGIC
class _HomeState extends State<Home> {
  int current_index = 0;
  List<Widget> pages = [ Students(), Analytics()];

  @override
  Widget build(BuildContext context) => HomeView(this);

  changeCurrentIndex(int index){
    setState(() {
      current_index = index;

    });
  }
}


// VIEW

class HomeView extends StatelessWidget {
  final _HomeState state;
  const HomeView(this.state,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: state.pages[state.current_index] ,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => state.changeCurrentIndex(index) ,
          currentIndex: state.current_index,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), title: UIHelper.buildText("Students")),
            BottomNavigationBarItem(icon: Icon(Icons.multiline_chart), title: UIHelper.buildText("Analytics"))
          ]
        ) ,
      ),
    ); 
  }
}