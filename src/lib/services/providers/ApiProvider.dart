import 'package:flutter/cupertino.dart';
import 'package:src/services/api/weather_api_i.dart';

class ApiProvider extends ChangeNotifier {
  WeatherApiI? _api;

  WeatherApiI? get api => _api;

  set api(WeatherApiI? value) {
    _api = value;
    notifyListeners();
  }
}