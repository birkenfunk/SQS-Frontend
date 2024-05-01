import 'package:flutter/cupertino.dart';
import 'package:src/services/api/weather_api_i.dart';

class ApiProvider extends ChangeNotifier {
  WeatherApiI? api;
}