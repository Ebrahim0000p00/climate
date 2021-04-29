import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';

const openWeatherMapUrl = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$kAPIKey&units=metric');

    return await networkHelper.getData();
  }

  Future getWeatherData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$kAPIKey&units=metric');
      return await networkHelper.getData();
    } catch (e) {
      print(e);
    }
  }

  String getWeatherIcon(int condition) {
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
