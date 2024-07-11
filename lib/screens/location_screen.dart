import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:untitled3/services/weather.dart';
import 'city_screen.dart';
class LocationScreen extends StatefulWidget {
  final  locationWeatherData;
  LocationScreen(this.locationWeatherData);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? text;
  int? temp;
  int? condition;
  String? cityName;
  WeatherModel? weather ;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeatherData);
  }
  void updateUI(dynamic weatherData){
    setState((){
        if(weatherData == null){
      temp = -1000;
      text = '';
      condition = -1000;
      print(condition);
      return;
    };
      double temp1 = weatherData['main']['temp'];
      print(temp1);
      temp = temp1.toInt();
      text = temp.toString();
      print(temp);
       cityName = weatherData['name'];
       print(cityName);
        print(weatherData['weather'][0]['id']);
       condition = weatherData['weather'][0]['id'];
      print(condition);
      weather = WeatherModel();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,elevation: 0 ),

                    onPressed: () async{
                      var weatherData = await weather?.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,elevation: 0, ),
                    onPressed: () async{
                      var typedName=await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }),

                      );
                      print(typedName );
                      if(typedName!=null){

                        var weatherData=await weather?.getCityWeather(typedName);
                        print(weatherData);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[

                    Text(

                      text!,
                      textAlign: TextAlign.start,

                      style: kTempTextStyle,
                    ),
                    Text(

                      weather!.getWeatherIcon(condition!),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weather?.getMessage(temp!)} in $cityName!",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
