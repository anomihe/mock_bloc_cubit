import 'dart:math';
import 'package:mock_weather_bloc_cubit/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
  Future<Weather> fetchDetailWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  late double cachedTemCelsius;
  @override
  Future<Weather> fetchDetailWeather(String cityName) {
    return Future.delayed(const Duration(seconds: 1), () {
      return Weather(
        cityName: cityName,
        temperaturCelsius: cachedTemCelsius,
        tepmFehrenheit: cachedTemCelsius * 1.8 + 32,
      );
    });
  }

  @override
  Future<Weather> fetchWeather(String cityName) {
    //simulates network delay
    return Future.delayed(const Duration(seconds: 1), () {
      final random = Random();

      //simulate some networkerror
      if (random.nextBool()) {
        throw NetworkError();
      }
      //since we are inside a fake repository, we need to cache the temperatur
      //in order to have the same one returned in for the detailed weather
      cachedTemCelsius = 20 + random.nextInt(15) + random.nextDouble();

      // Return 'fetchec" weather
      return Weather(
        cityName: cityName,
        temperaturCelsius: cachedTemCelsius,
        tepmFehrenheit: 0.0,
      );
    });
  }
}

class NetworkError extends Error {
  NetworkError();
}
