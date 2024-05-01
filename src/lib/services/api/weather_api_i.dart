import 'package:dio/dio.dart';
import 'package:src/entities/weather_dto.dart';
import 'package:src/services/api/weather_api.dart';

abstract interface class WeatherApiI{
  Future<WeatherDto?> getWeather(String location);

  Future<bool?> isHealthy();

  static WeatherApiI create(String host, int port, bool useHttps){
    String baseUrl;
    if(useHttps){
      baseUrl = 'https://$host:$port/api/v1';
    }else {
      baseUrl = 'http://$host:$port/api/v1';
    }
    return WeatherApi(
        Dio(
            BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: const Duration(milliseconds: 3000),
                receiveTimeout: const Duration(milliseconds: 3000),
                sendTimeout: const Duration(milliseconds: 3000)
            )
        )
    );
  }
}