import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:src/entities/weather_dto.dart';
import 'package:src/services/api/weather_api.dart';

import '../mocks/mock.mocks.dart';

void main() {
  getWeatherTest();
  getWeatherFailTest();
  getHealthTest();
  getHealthFailTest();
}

WeatherDto? weatherDto =
    WeatherDto('test', '20°C', '50%', 5, '10km/h', 'Sunny', '2024-01-01');

void getWeatherTest() {
  MockDio dio = MockDio();
  when(dio.get(any)).thenAnswer((_) async => Response(
      statusCode: 200,
      data: weatherDto?.toJson(),
      requestOptions: RequestOptions(path: '')));
  WeatherApi api = WeatherApi(dio);
  test('Get weather', () async {
    final weatherResponse = await api.getWeather('test');
    expect(weatherResponse, isNotNull);
    expect(weatherResponse, equals(weatherDto));
  });
}

void getWeatherFailTest() {
  MockDio dio = MockDio();
  when(dio.get('/weather/test')).thenThrow(DioExceptionType.badResponse);
  WeatherApi api = WeatherApi(dio);
  test('Get weather fails', () async {
    WeatherDto? weatherResponse = await api.getWeather('test');
    expect(weatherResponse, isNull);
  });
}

void getHealthTest() {
  MockDio dio = MockDio();
  when(dio.get('/health')).thenAnswer((_) async =>
      Response(statusCode: 200, requestOptions: RequestOptions(path: '')));
  WeatherApi api = WeatherApi(dio);
  test('Get health', () async {
    final healthResponse = await api.isHealthy();
    expect(healthResponse, isNotNull);
    expect(healthResponse, isInstanceOf<bool>());
    expect(healthResponse, equals(true));
  });
}

void getHealthFailTest() {
  MockDio dio = MockDio();
  when(dio.get('/health')).thenThrow(DioExceptionType.badResponse);
  WeatherApi api = WeatherApi(dio);
  test('Get health fails', () async {
    final healthResponse = await api.isHealthy();
    expect(healthResponse, isFalse);
  });
}
