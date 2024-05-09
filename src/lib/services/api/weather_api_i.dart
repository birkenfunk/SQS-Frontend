import 'package:dio/dio.dart';
import 'package:src/entities/weather_dto.dart';
import 'package:src/services/api/weather_api.dart';

abstract interface class WeatherApiI{
  Future<WeatherDto?> getWeather(String location);

  Future<bool?> isHealthy();
}