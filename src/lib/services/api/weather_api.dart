import 'package:dio/dio.dart';
import 'package:src/entities/weather_dto.dart';
import 'package:src/services/api/weather_api_i.dart';

class WeatherApi implements WeatherApiI {
  final Dio _dio;

  WeatherApi(this._dio);

  @override
  Future<WeatherDto?> getWeather(String location) async {
    Response response;
    try {
      response = await _dio.get('/weather/$location');
    } on DioExceptionType catch (_) {
      return null;
    }
    WeatherDto? weather = WeatherDto.fromJson(response.data);
    return weather;
  }

  @override
  Future<bool?> isHealthy() async {
    try {
      Response response = await _dio.get('/health');
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  // for testing purposes only
  Dio get dio => _dio;
}

class WeatherFactory {
  static bool _isUnderTest = false;
  static WeatherApiI? _testApi;

  static WeatherApiI create(String host, int port, bool useHttps) {
    if (_isUnderTest) {
      if (_testApi != null) {
        return _testApi as WeatherApiI;
      }
      throw StateError('Test API not set');
    }
    String protocol = useHttps ? 'https' : 'http';
    String url = '$protocol://$host:$port/api/v1';
    BaseOptions options = BaseOptions(baseUrl: url);
    Dio dio = Dio(options);
    return WeatherApi(dio);
  }

  // for testing purposes only
  static void setTestApi(WeatherApiI api) {
    _isUnderTest = true;
    _testApi = api;
  }

  // for testing purposes only
  static void reset() {
    _isUnderTest = false;
    _testApi = null;
  }
}
