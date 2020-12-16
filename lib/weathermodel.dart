import 'package:eigital_app/location.dart';
import 'package:eigital_app/networking.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String typedCityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$typedCityName&appid=80b971acf4915dbb314161d7035430fa');
    var weatherData = await networkHelper.getWeatherData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=80b971acf4915dbb314161d7035430fa');
    var weatherData = await networkHelper.getWeatherData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 't';
    } else if (condition < 400) {
      return 's';
    } else if (condition < 600) {
      return 'hr';
    } else if (condition < 700) {
      return 'sn';
    } else if (condition < 800) {
      return 'hc';
    } else if (condition == 800) {
      return 'c';
    } else if (condition <= 804) {
      return 'lc';
    } else {
      return '🤷‍';
    }
  }
}
