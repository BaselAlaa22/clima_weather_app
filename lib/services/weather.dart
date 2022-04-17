import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:geolocator/geolocator.dart';

const apiKey = '4a3881a51b7e5200c63eaf85cfc6a6f9';
const openWeatherMapURL = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  static String getWeatherBackground(int condition, String icon) {
    if (condition < 300) {
      return 'images/thunderstorm.jpg';
    } else if (condition < 400) {
      return 'images/drizzle.jpg';
    } else if (condition < 600) {
      return 'images/rainy.jpg';
    } else if (condition < 700) {
      return 'images/snow.jpg';
    } else if (condition < 800) {
      switch (condition) {
        case 701:
          return 'images/mist.jpg';
          break;
        case 711:
          return 'images/smoke.jpg';
          break;
        case 721:
          return 'images/mist.jpg';
          break;
        case 731:
          return 'images/dust.jpg';
          break;
        case 741:
          return 'images/mist.jpg';
          break;
        case 751:
          return 'images/dust.jpg';
          break;
        case 761:
          return 'images/dust.jpg';
          break;
        case 762:
          return 'images/ash.jpg';
          break;
        case 771:
          return 'images/squall.jpg';
          break;
        case 781:
          return 'images/tornado.jpg';
          break;
      }
    } else if (condition == 800) {
      if (icon[2] == 'd') {
        return 'images/clear_day.jpg';
      }
      return 'images/clear_night.jpg';
    } else if (condition <= 804) {
      if (icon[2] == 'd') {
        return 'images/clouds_day.jpg';
      }
      return 'images/clouds_night.jpeg';
    } else {
      return '🤷‍';
    }
  }

  static String getMessage(int temp) {
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

  static Future<dynamic> getLocationWeather() async {
    Position position = await Location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            "$openWeatherMapURL?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric");

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  static Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        url: '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}
