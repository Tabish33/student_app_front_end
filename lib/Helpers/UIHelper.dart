import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UIHelper{

  static showLoadingDialog(context) {
    var context2 = context;
    return showCupertinoModalPopup(
        context: context2,
        builder: (context2) {
          return Center(
            child: Container(
              width: 200.0,
              height: 200.0,
              child: Center(
                child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    )
                ),
              ),
            ),
          );
        }
    );
  }

  static showCustomChildDialog(context, child) {
    var context2 = context;
    return showCupertinoModalPopup(
        context: context2,
        builder: (context2) {
          return Center(
            child: Card(
              child:child
            )
          );
        }
    );
  }

  static Future buildshowCupertinoModalPopup(context,body)async{
    return await showCupertinoModalPopup(
      context: context,
      builder: (context){
        return body;
      }
    );
  }
  
  static buildText(String text,{size=15.0,FontWeight weight=FontWeight.normal,Color color=Colors.black,
            FontStyle fontStyle=FontStyle.normal}){
    return Text(text, style: GoogleFonts.lato(textStyle: TextStyle(
      fontSize: size ,
      fontWeight : weight,
      color : color,
    )));
  }

  static buildCutiveMonoText(String text,{size=16.0,FontWeight weight=FontWeight.w600,Color color=Colors.black,
            }){
    return Text(text, style: GoogleFonts.cutiveMono(textStyle: TextStyle(
      fontSize: size ,
      fontWeight : weight,
      color : color,
    )));
  }

  static buildFormTextField(text,{TextEditingController controller=null,bool obscureText=false, 
            TextInputType keyboardType=TextInputType.text,Function onChangedFunc=null,
            Function validator=null,Function onSavedFunc=null,int maxLines=1}){

    return TextFormField(
      controller:  controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (val) => validator(val),
      onChanged:  (val){
        if(onChangedFunc != null)onChangedFunc(val);
      },
      onSaved: (val){
        if(onSavedFunc != null)onSavedFunc(val);
      },
      decoration: InputDecoration(
        labelText: text,
      ),
    );
  }

  static buildRaisedButton(text, Function onPressedFunc,{double height=70.0,double width=double.infinity,double elevation=2.0,
          double borderRadius=5.0,Color color=Colors.black,Color textColor=Colors.white,
          FontWeight fontWeight=FontWeight.w800,double fontSize=18.0}){

    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(10.0),
        child: RaisedButton(
          elevation: elevation,
          shape: buildRoundedRectangleBorder(radius:borderRadius),
          onPressed: () => onPressedFunc(),
          color: color,
          textColor: textColor,
          child: Text(text, 
              style: TextStyle(fontWeight: fontWeight, fontSize: fontSize),),
        ),
      );
  }

  static buildRoundedRectangleBorder({double radius=10.0}){
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius)
    );
  }

  static buildBorderRadiusOnly({tl=0.0,tr=0.0,br=0.0,bl=0.0}){
    return BorderRadius.only(
      topLeft: Radius.circular(tl),
      topRight: Radius.circular(tr),
      bottomRight: Radius.circular(br),
      bottomLeft: Radius.circular(bl)
    );
  }

  static buildExtendedFloatingActionButton(String label, Function onPressedFunc,
          {Color labelColor=Colors.white, IconData icon = Icons.add,Color backgroundColor=Colors.black54,FontWeight labelWeight=FontWeight.w700}){
    
    return FloatingActionButton.extended(
      onPressed: ()=> onPressedFunc(),
      label: buildText(label, color: labelColor, weight: labelWeight),
      icon: Icon(icon),
      backgroundColor: backgroundColor,
    );
  }

  static buildFloatingActionButton(String label, Function onPressedFunc,
          {Color labelColor=Colors.white, IconData icon = Icons.add,Color backgroundColor=Colors.black54,FontWeight labelWeight=FontWeight.w700}){
    
    return FloatingActionButton(
      onPressed: ()=> onPressedFunc(),
      child: Icon(icon),
      backgroundColor: backgroundColor,
    );
  }
}