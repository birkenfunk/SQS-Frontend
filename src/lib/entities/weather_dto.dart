class WeatherDto{
  final String _location;
  final String _temperature;
  final String _humidity;
  final int _sunHours;
  final String _windSpeed;
  final String _weather;
  final String _date;

  WeatherDto(this._location, this._temperature, this._humidity, this._sunHours,
      this._windSpeed, this._weather, this._date);

  String get date => _date;

  String get weather => _weather;

  String get windSpeed => _windSpeed;

  int get sunHours => _sunHours;

  String get humidity => _humidity;

  String get temperature => _temperature;

  String get location => _location;

  Map<String, dynamic> toJson() {
    return {
      'location': _location,
      'temperature': _temperature,
      'humidity': _humidity,
      'sunHours': _sunHours,
      'windSpeed': _windSpeed,
      'weather': _weather,
      'date': _date
    };
  }

  factory WeatherDto.fromJson(Map<String, dynamic> json) {
    return WeatherDto(
      json['location'],
      json['temperature'],
      json['humidity'],
      json['sunHours'],
      json['windSpeed'],
      json['weather'],
      json['date']
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherDto &&
          runtimeType == other.runtimeType &&
          _location == other._location &&
          _temperature == other._temperature &&
          _humidity == other._humidity &&
          _sunHours == other._sunHours &&
          _windSpeed == other._windSpeed &&
          _weather == other._weather &&
          _date == other._date;

  @override
  int get hashCode =>
      _location.hashCode ^
      _temperature.hashCode ^
      _humidity.hashCode ^
      _sunHours.hashCode ^
      _windSpeed.hashCode ^
      _weather.hashCode ^
      _date.hashCode;
}