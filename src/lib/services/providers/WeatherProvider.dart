import 'package:flutter/cupertino.dart';
import 'package:src/entities/weather_dto.dart';

class WeatherProvider extends ChangeNotifier{
  WeatherDto? _weatherDto;

  WeatherDto? get weatherDto => _weatherDto;

  set weatherDto(WeatherDto? value) {
    _weatherDto = value;
    notifyListeners();
  }
}