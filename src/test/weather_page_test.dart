import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:src/components/user_options.dart';
import 'package:src/entities/weather_dto.dart';
import 'package:src/services/api/weather_api.dart';
import 'package:src/services/providers/api_provider.dart';
import 'package:src/services/providers/weather_provider.dart';
import 'package:src/weather/weather_page.dart';

import 'widget_test.mocks.dart';

void main() {
  testWeatherPageEmpty();
  testWeatherPageWithWeatherData();
  testWeatherPageRequestWeather();
  WeatherFactory.reset();
}

// Setup testWidget

Widget setupTestWidget(Route standardRoute, Route routeTo,
    List<SingleChildWidget> providers, NavigatorObserver mockObserver) {
  Widget testWidget = MultiProvider(
      providers: providers,
      child: MaterialApp(
        navigatorObservers: [mockObserver],
        initialRoute: '/weather',
        onGenerateRoute: (settings) {
          if (settings.name == '/weather') {
            return standardRoute;
          } else {
            return routeTo;
          }
        },
      ));
  return testWidget;
}

void testWeatherPageEmpty() {
  return testWidgets('Widget Test Default State of Weather Page',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final mockApiProvider = MockApiProvider();
    final mockWeatherProvider = MockWeatherProvider();

    when(mockWeatherProvider.weatherDto).thenReturn(null);

    ApiProvider apiProvider = mockApiProvider;
    WeatherProvider weatherProvider = mockWeatherProvider;

    final standardRoute =
        MaterialPageRoute(builder: (_) => const WeatherPage());
    final routeTo = MaterialPageRoute(builder: (_) => Container());

    Widget testWidget = setupTestWidget(
        standardRoute,
        routeTo,
        [
          ChangeNotifierProvider(create: (context) => apiProvider),
          ChangeNotifierProvider(create: (context) => weatherProvider)
        ],
        mockObserver);
    await tester.pumpWidget(testWidget);

    expect(find.text('Weather Page'), findsOneWidget);
    expect(find.widgetWithIcon(UserOptions, Icons.person), findsOneWidget);
    expect(find.text('City'), findsOneWidget);
    expect(find.text('Get Weather'), findsOneWidget);
    expect(find.text('Location:'), findsNothing);
    expect(find.text('Date:'), findsNothing);
    expect(find.text('Weather:'), findsNothing);
    expect(find.text('Temperature:'), findsNothing);
    expect(find.text('Windspeed:'), findsNothing);
    expect(find.text('Humidity:'), findsNothing);
    expect(find.text('Sun hours:'), findsNothing);
  });
}

void testWeatherPageWithWeatherData() {
  return testWidgets('Widget Test for Weather Page with Weather Data',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final mockApiProvider = MockApiProvider();
    final mockWeatherProvider = MockWeatherProvider();

    final weather = WeatherDto(
        "Munich",
        "2022-01-01",
        "Sunny",
        6,
        "10°C",
        "10km/h",
        "50%");
    when(mockWeatherProvider.weatherDto).thenReturn(weather);


    ApiProvider apiProvider = mockApiProvider;
    WeatherProvider weatherProvider = mockWeatherProvider;

    final standardRoute =
    MaterialPageRoute(builder: (_) => const WeatherPage());
    final routeTo = MaterialPageRoute(builder: (_) => Container());

    Widget testWidget = setupTestWidget(
        standardRoute,
        routeTo,
        [
          ChangeNotifierProvider(create: (context) => apiProvider),
          ChangeNotifierProvider(create: (context) => weatherProvider)
        ],
        mockObserver);
    await tester.pumpWidget(testWidget);

    expect(find.text('Weather Page'), findsOneWidget);
    expect(find.widgetWithIcon(UserOptions, Icons.person), findsOneWidget);
    expect(find.text('City'), findsOneWidget);
    expect(find.text('Get Weather'), findsOneWidget);
    expect(find.text('Location:'), findsOneWidget);
    expect(find.text(weather.location), findsOneWidget);
    expect(find.text('Date:'), findsOneWidget);
    expect(find.text(weather.date), findsOneWidget);
    expect(find.text('Weather:'), findsOneWidget);
    expect(find.text(weather.weather), findsOneWidget);
    expect(find.text('Temperature:'), findsOneWidget);
    expect(find.text(weather.temperature), findsOneWidget);
    expect(find.text('Windspeed:'), findsOneWidget);
    expect(find.text(weather.windSpeed), findsOneWidget);
    expect(find.text('Humidity:'), findsOneWidget);
    expect(find.text(weather.humidity), findsOneWidget);
    expect(find.text('Sun hours:'), findsOneWidget);
  });
}

void testWeatherPageRequestWeather(){
  return testWidgets('Widget Test for Select Server State Change Url',
  (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final mockApi = MockWeatherApiI();

    final weatherProvider = WeatherProvider();
    ApiProvider apiProvider = ApiProvider();

    apiProvider.api = mockApi;

    final weather = WeatherDto(
        "Munich",
        "2022-01-01",
        "Sunny",
        6,
        "10°C",
        "10km/h",
        "50%");

    when(mockApi.getWeather('munich')).thenAnswer((_) => Future.value(weather));

    final standardRoute =
    MaterialPageRoute(builder: (_) => const WeatherPage());
    final routeTo = MaterialPageRoute(builder: (_) => Container());

    Widget testWidget = setupTestWidget(
        standardRoute,
        routeTo,
        [
          ChangeNotifierProvider(create: (context) => apiProvider),
          ChangeNotifierProvider(create: (context) => weatherProvider)
        ],
        mockObserver);
    await tester.pumpWidget(testWidget);

    expect(find.text('Weather Page'), findsOneWidget);
    expect(find.widgetWithIcon(UserOptions, Icons.person), findsOneWidget);
    expect(find.text('City'), findsOneWidget);
    expect(find.text('Get Weather'), findsOneWidget);
    expect(find.text('Location:'), findsNothing);
    expect(find.text('Date:'), findsNothing);
    expect(find.text('Weather:'), findsNothing);
    expect(find.text('Temperature:'), findsNothing);
    expect(find.text('Windspeed:'), findsNothing);
    expect(find.text('Humidity:'), findsNothing);
    expect(find.text('Sun hours:'), findsNothing);

    await tester.enterText(find.byKey(const Key('select_city_input')), 'munich');
    await tester.pump();

    expect(find.text('Weather Page'), findsOneWidget);
    expect(find.widgetWithIcon(UserOptions, Icons.person), findsOneWidget);
    expect(find.text('munich'), findsOneWidget);
    expect(find.text('City'), findsOneWidget);
    expect(find.text('Get Weather'), findsOneWidget);
    expect(find.text('Location:'), findsNothing);
    expect(find.text('Date:'), findsNothing);
    expect(find.text('Weather:'), findsNothing);
    expect(find.text('Temperature:'), findsNothing);
    expect(find.text('Windspeed:'), findsNothing);
    expect(find.text('Humidity:'), findsNothing);
    expect(find.text('Sun hours:'), findsNothing);

    await tester.tap(find.byKey(const Key('get_weather_button')));
    await tester.pumpAndSettle();

    // check if weatherApi was called
    verify(mockApi.getWeather('munich')).called(1);

    expect(find.text('Weather Page'), findsOneWidget);
    expect(find.widgetWithIcon(UserOptions, Icons.person), findsOneWidget);
    expect(find.text('City'), findsOneWidget);
    expect(find.text('Get Weather'), findsOneWidget);
    expect(find.text('Location:'), findsOneWidget);
    expect(find.text(weather.location), findsOneWidget);
    expect(find.text('Date:'), findsOneWidget);
    expect(find.text(weather.date), findsOneWidget);
    expect(find.text('Weather:'), findsOneWidget);
    expect(find.text(weather.weather), findsOneWidget);
    expect(find.text('Temperature:'), findsOneWidget);
    expect(find.text(weather.temperature), findsOneWidget);
    expect(find.text('Windspeed:'), findsOneWidget);
    expect(find.text(weather.windSpeed), findsOneWidget);
    expect(find.text('Humidity:'), findsOneWidget);
    expect(find.text(weather.humidity), findsOneWidget);
    expect(find.text('Sun hours:'), findsOneWidget);
  });
}
