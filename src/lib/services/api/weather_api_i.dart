import 'package:src/entities/weather_dto.dart';

abstract interface class WeatherApiI{
  Future<WeatherDto?> getWeather(String location);

  Future<bool?> isHealthy();
}