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
}