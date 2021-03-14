import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; //location name for UI
  String time;  // the time in that location
  String flag;  // url to an asset flag icon
  String url;   // location url for api endpoint
  bool isDaytime; // true or false if daytime or not

  //constructor with named parameter
  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{

    try{
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      //print(response.body);  //returns a json object(string)
      Map data = jsonDecode(response.body);  //converts json object to map
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      // create DateTime object

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }

    catch(e){
      print('caught error: $e');
      time = 'Could not get time data';
    }

  }
}

