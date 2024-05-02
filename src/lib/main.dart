import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/services/providers/ApiProvider.dart';
import 'package:src/server/SelectServerPage.dart';
import 'package:src/services/providers/WeatherProvider.dart';
import 'package:src/weather/WeatherPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiProvider()),
        ChangeNotifierProvider(create: (context) => WeatherProvider())
      ],
      child: const WeatherApp(),
    );
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SelectServerPage(),
        '/weather': (context) => const WeatherPage(),
      },
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
