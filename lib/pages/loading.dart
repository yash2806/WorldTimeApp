import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {
    WorldTime instance = WorldTime(url: 'Asia/Kolkata', location: 'Kolkata', flag: 'india.jpg');
    await instance.getTime();   //this await keyword will not work if the type of getTime function is void or something else
                                //since it's a async function, so it should have Future as type.
    Navigator.pushReplacementNamed(context, '/home', arguments: {

      'location' : instance.location,
      'flag' : instance.flag,
      'time' : instance.time,
      'isDaytime' : instance.isDaytime,

    });  //similar to pushNamed but while pushNamed used to stack new page over home page this will replace it with new page.
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 50.0,
        ),
      )
    );
  }
}
