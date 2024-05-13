import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:src/components/user_options.dart';
import 'package:src/main.dart';

void main(){
  testWidgets('Test switch Server', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial page is SelectServerPage
    expect(find.text('Select Server'), findsOneWidget);
    expect(find.text('localhost'), findsOneWidget);
    expect(find.text('4000'), findsOneWidget);
    expect(find.text('http'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Server not reachable'), findsNothing);

    // Tap the Next button and trigger a frame.
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Verify that the WeatherPage is displayed without any data

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

    // Press UserOptions button and trigger a frame.
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Verify that the User Options are is displayed
    expect(find.text('Select Server'), findsOneWidget);

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

    // Tap Select Server button and trigger a frame.
    await tester.tap(find.byKey(const Key('logout')));
    await tester.pumpAndSettle();

    // Verify that the SelectServerPage is displayed
    // Verify that the initial page is SelectServerPage
    expect(find.text('Select Server'), findsOneWidget);
    expect(find.text('localhost'), findsOneWidget);
    expect(find.text('4000'), findsOneWidget);
    expect(find.text('http'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Server not reachable'), findsNothing);
  });
}