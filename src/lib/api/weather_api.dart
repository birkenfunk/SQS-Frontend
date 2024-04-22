import 'package:src/api/weather_api_i.dart';
import 'package:src/entities/weather_dto.dart';

class WeatherApi implements WeatherApiI{
  @override
  Future<WeatherDto> getWeather(String location) {
    // TODO: implement getWeather
    throw UnimplementedError();
  }

  @override
  Future<bool> isHealthy() {
    // TODO: implement isHealthy
    throw UnimplementedError();
  }

}