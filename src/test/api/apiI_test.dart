
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:src/api/weather_api.dart';
import 'package:src/api/weather_api_i.dart';

void main(){
  createWithHttpTest();
  createWithHttpsTest();
}

void createWithHttpTest() {
  WeatherApi result = WeatherApiI.create('localhost', 8080, false) as WeatherApi;
  Dio createdDio = result.dio;
  test('Dio has correct Base URL', () {
    expect(createdDio.options.baseUrl, 'http://localhost:8080/api/v1');
  });
}

void createWithHttpsTest() {
  WeatherApi result = WeatherApiI.create('test.de', 9000, true) as WeatherApi;
  Dio createdDio = result.dio;
  test('Dio has correct Base URL', () {
    expect(createdDio.options.baseUrl, 'https://test.de:9000/api/v1');
  });
}