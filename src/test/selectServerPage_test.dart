import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:src/server/SelectServerPage.dart';
import 'package:src/services/api/weather_api.dart';
import 'package:src/services/providers/ApiProvider.dart';

import 'widget_test.mocks.dart';

void main() {
  testSelectServerStatePrefilled();
  testSelectServerStateServerNotReachable();
}

// Setup testWidget

Widget setupTestWidget(Route standardRoute, Route routeTo,
    List<SingleChildWidget> providers, NavigatorObserver mockObserver) {
  Widget testWidget = MultiProvider(
      providers: providers,
      child: MaterialApp(
        navigatorObservers: [mockObserver],
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return standardRoute;
          } else {
            return routeTo;
          }
        },
      ));
  return testWidget;
}

void testSelectServerStatePrefilled() {
  return testWidgets('Widget Test for Select Server State',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final mockApiProvider = MockApiProvider();
    final mockApi = MockWeatherApiI();

    // setup WeatherApiI mock
    WeatherFactory.reset();
    WeatherFactory.setTestApi(mockApi);
    // when the api is called with the url localhost:3000, it should return true else false
    when(mockApi.isHealthy()).thenAnswer((_) => Future.value(true));
    when(mockApiProvider.api).thenReturn(mockApi);

    ApiProvider apiProvider = mockApiProvider;

    final standardRoute =
        MaterialPageRoute(builder: (_) => const SelectServerPage());
    final routeTo = MaterialPageRoute(builder: (_) => Container());

    Widget testWidget = setupTestWidget(
        standardRoute,
        routeTo,
        [ChangeNotifierProvider(create: (context) => apiProvider)],
        mockObserver);
    await tester.pumpWidget(testWidget);

    expect(find.text('Select Server'), findsOneWidget);
    expect(find.text('localhost'), findsOneWidget);
    expect(find.text('4000'), findsOneWidget);
    expect(find.text('http'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Server not reachable'), findsNothing);

    await tester.tap(find.byKey(const Key('nextButton_serverForm')));
    await tester.pumpAndSettle();

    expect(find.text('Server not reachable'), findsNothing);
    verify(mockApi.isHealthy()).called(1);
    verify(mockObserver.didPush(any, any));
  });
}

void testSelectServerStateServerNotReachable() {
  return testWidgets('Widget Test for Select Server State Server Not Reachable',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final mockApiProvider = MockApiProvider();
    final mockApi = MockWeatherApiI();

    // setup WeatherApiI mock
    WeatherFactory.reset();
    WeatherFactory.setTestApi(mockApi);
    // when the api is called with the url localhost:3000, it should return true else false
    when(mockApi.isHealthy()).thenAnswer((_) => Future.value(false));
    when(mockApiProvider.api).thenReturn(mockApi);

    ApiProvider apiProvider = mockApiProvider;

    final standardRoute =
        MaterialPageRoute(builder: (_) => const SelectServerPage());
    final routeTo = MaterialPageRoute(builder: (_) => Container());

    Widget testWidget = setupTestWidget(
        standardRoute,
        routeTo,
        [ChangeNotifierProvider(create: (context) => apiProvider)],
        mockObserver);
    await tester.pumpWidget(testWidget);

    expect(find.text('Select Server'), findsOneWidget);
    expect(find.text('localhost'), findsOneWidget);
    expect(find.text('4000'), findsOneWidget);
    expect(find.text('http'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Server not reachable'), findsNothing);

    await tester.tap(find.byKey(const Key('nextButton_serverForm')));
    await tester.pumpAndSettle();

    expect(find.text('Server not reachable'), findsOneWidget);
    verify(mockApi.isHealthy()).called(1);
  });
}
