import 'package:flutter_test/flutter_test.dart';
import 'package:src/entities/weather_dto.dart';

void main() {
  testCreateDto();
  testEquals();
  testEqualsFalse();
  testHashCode();
  testToJson();
  testFromJson();
  testRoundTrip();
}

void testCreateDto() {
  WeatherDto weatherDto =
      WeatherDto('test', '20°C', '50%', 5, '10km/h', 'Sunny', '2024-01-01');
  test('Create WeatherDto', () {
    expect(weatherDto.location, 'test');
    expect(weatherDto.temperature, '20°C');
    expect(weatherDto.humidity, '50%');
    expect(weatherDto.sunHours, 5);
    expect(weatherDto.windSpeed, '10km/h');
    expect(weatherDto.weather, 'Sunny');
    expect(weatherDto.date, '2024-01-01');
  });
}

void testEquals() {
  WeatherDto weatherDto1 =
      WeatherDto('test', '20°C', '50%', 5, '10km/h', 'Sunny', '2024-01-01');
  WeatherDto weatherDto2 =
      WeatherDto('test', '20°C', '50%', 5, '10km/h', 'Sunny', '2024-01-01');
  test('WeatherDto equals', () {
    expect(weatherDto1, equals(weatherDto2));
  });
}

void testEqualsFalse() {
  WeatherDto weatherDto1 =
      WeatherDto('test', '20°C', '50%', 5, '10km/h', 'Sunny', '2024-01-01');
  WeatherDto weatherDto2 =
      WeatherDto('test', '20°C', '50%', 5, '10km/h', 'Sunny', '2024-01-02');
  test('WeatherDto equals false', () {
    expect(weatherDto1, isNot(equals(weatherDto2)));
  });
}

void testHashCode() {
  WeatherDto weatherDto1 =
      WeatherDto('test', '20°C', '50%', 5, '10km/h', 'Sunny', '2024-01-01');
  WeatherDto weatherDto2 =
      WeatherDto('test', '20°C', '50%', 5, '10km/h', 'Sunny', '2024-01-01');
  test('WeatherDto hashCode', () {
    expect(weatherDto1.hashCode, equals(weatherDto2.hashCode));
  });
}

void testToJson() {
  WeatherDto weatherDto =
      WeatherDto('test', '20°C', '50%', 5, '10km/h', 'Sunny', '2024-01-01');
  test('WeatherDto toJson', () {
    expect(weatherDto.toJson(), {
      'location': 'test',
      'temperature': '20°C',
      'humidity': '50%',
      'sunHours': 5,
      'windSpeed': '10km/h',
      'weather': 'Sunny',
      'date': '2024-01-01'
    });
  });
}

void testFromJson() {
  Map<String, dynamic> json = {
    'location': 'test',
    'temperature': '20°C',
    'humidity': '50%',
    'sunHours': 5,
    'windSpeed': '10km/h',
    'weather': 'Sunny',
    'date': '2024-01-01'
  };
  test('WeatherDto fromJson', () {
    expect(WeatherDto.fromJson(json), equals(WeatherDto('test', '20°C', '50%', 5, '10km/h', 'Sunny', '2024-01-01')));
  });
}

void testRoundTrip() {
  WeatherDto weatherDto =
      WeatherDto('test', '20°C', '50%', 5, '10km/h', 'Sunny', '2024-01-01');
  test('WeatherDto round trip', () {
    expect(WeatherDto.fromJson(weatherDto.toJson()), equals(weatherDto));
  });
}

