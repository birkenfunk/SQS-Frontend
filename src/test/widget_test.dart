// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:src/services/api/weather_api_i.dart';
import 'package:src/services/providers/ApiProvider.dart';
import 'package:src/services/providers/WeatherProvider.dart';

@GenerateNiceMocks([MockSpec<NavigatorObserver>(), MockSpec<ApiProvider>(), MockSpec<WeatherApiI>(), MockSpec<WeatherProvider>()])
void main() {}
