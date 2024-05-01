import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:src/entities/weather_dto.dart';
import 'package:src/services/api/weather_api_i.dart';

class WeatherApi implements WeatherApiI{

  final Dio _dio;

  WeatherApi(this._dio);

  @override
  Future<WeatherDto?> getWeather(String location) async{
    Response response;
    try {
      response = await _dio.get('/weather/$location');
    } on DioExceptionType catch (_) {
      return null;
    }
    WeatherDto? weather = WeatherDto.fromJson(response.data);
    return weather;
  }

  @override
  Future<bool?> isHealthy() async {
    try {
      Response response = await _dio.get('/health');
      return response.statusCode == 200;
    } on DioException catch (_) {
      return false;
    }
  }

  // for testing purposes only
  Dio get dio => _dio;
}