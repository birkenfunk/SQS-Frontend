import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/entities/weather_dto.dart';
import 'package:src/services/providers/WeatherProvider.dart';

class WeatherDisplay extends StatefulWidget {
  const WeatherDisplay({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  @override
  Widget build(BuildContext context) {
    WeatherDto? weatherDto = context.watch<WeatherProvider>().weatherDto;
    weatherDto ??= WeatherDto("", "", "", 0, "", "", "");

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 6,
      children: [
        const Center(
          child: Text("Location:"),
        ),
        Center(
          child: Text(weatherDto.location),
        ),
        const Center(
          child: Text("Date:"),
        ),
        Center(
          child: Text(weatherDto.date),
        ),
        const Center(
          child: Text("Weather:"),
        ),
        Center(
          child: Text(weatherDto.weather),
        ),
        const Center(
          child: Text("Temperature:"),
        ),
        Center(
          child: Text(weatherDto.temperature),
        ),
        const Center(
          child: Text("Windspeed:"),
        ),
        Center(
          child: Text(weatherDto.windSpeed),
        ),
        const Center(
          child: Text("Humidity:"),
        ),
        Center(
          child: Text(weatherDto.humidity),
        ),
        const Center(
          child: Text("Sun hours:"),
        ),
        Center(child: Text(weatherDto.sunHours.toString())),
      ],
    );
  }
}
