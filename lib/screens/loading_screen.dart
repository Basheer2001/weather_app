
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';
import 'package:untitled3/services/weather.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
 double? latitude;
 double? longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }
  void getLocationData()async{
    var weatherData = await  WeatherModel().getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(weatherData);}));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 50.0,
          )
      ),
    );
  }
}
