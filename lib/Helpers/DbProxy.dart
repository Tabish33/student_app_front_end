import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbProxy{
  static const url = "http://10.0.2.2:3000";
  // static const url = "http://192.168.1.6:3000";
  // static const url = "https://whispering-headland-20154.herokuapp.com";

  static Future<Response> getData(ref) async{
    Map<String,String> headers = await getHeader();
    return await get("$url/$ref",headers: headers);
  }

  static Future<Response> postData(ref, body) async{
    Map<String,String> headers = await getHeader();
    return await post("$url/$ref",body: body, headers: headers,);
  }

  static deleteData(){

  }

  static updateData(ref, body)async{
    Map<String,String> headers = await getHeader();
   return await patch("$url/$ref",body: body, headers: headers);
  }

  static getHeader()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get("token");
    Map<String, String> headers = {"Content-type": "application/json",'Authorization': "Bearer $token"};
    return  headers;
  }

  static getUserId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("user_id");
  }
}