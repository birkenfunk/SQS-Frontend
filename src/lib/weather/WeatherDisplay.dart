import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/components/StartScafold.dart';
import 'package:src/entities/weather_dto.dart';
import 'package:src/services/providers/WeatherProvider.dart';

class WeatherDisplay extends StatefulWidget{
  const WeatherDisplay({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherDisplayState();

}

class _WeatherDisplayState extends State<WeatherDisplay> {
  @override
  Widget build(BuildContext context) {
    WeatherDto? weatherDto = context.watch<WeatherProvider>().weatherDto;
    weatherDto ??= WeatherDto("", "", "", 0, "", "", "");

    String toDisplay = weatherDto.toString();

    return Column(
      children: [
        Row(
          children: [
            const Text("Location:"),
            Text(weatherDto.location)
          ],
        ),
        Row(
          children: [
            const Text("Date:"),
            Text(weatherDto.date)
          ],
        ),
        Row(
          children: [
            const Text("Weather:"),
            Text(weatherDto.weather)
          ],
        ),
        Row(
          children: [
            const Text("Temperature:"),
            Text(weatherDto.temperature)
          ],
        ),
        Row(
          children: [
            const Text("Windspeed:"),
            Text(weatherDto.windSpeed)
          ],
        ),
        Row(
          children: [
            const Text("Humidity:"),
            Text(weatherDto.humidity)
          ],
        ),
        Row(
          children: [
            const Text("Sun hours:"),
            Text(weatherDto.sunHours.toString())
          ],
        ),
      ],
    );
  }
}
