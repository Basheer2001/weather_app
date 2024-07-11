import '../services/location.dart';
import '../services/networking.dart';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey='1bdb31dc1e888b9940f2540cb5c08b1e';
class WeatherModel {
  Future<dynamic> getCityWeather(String cityName){
    NetworkHelper networkhelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = networkhelper.getData();
    return weatherData;

  }
  Future<dynamic> getLocationWeather()async{
    Location l = Location();
    await l.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?lat=${l.latitude}&lon=${l.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if(condition==-1000){
      return'error❌';
    }
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }

  }

  String getMessage(int temp) {
    if(temp==-1000){
        return'error❌';
    }
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
