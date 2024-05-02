import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:src/components/StartScafold.dart';
import 'package:src/components/UserOptions.dart';
import 'package:src/entities/weather_dto.dart';
import 'package:src/services/providers/WeatherProvider.dart';
import 'package:src/weather/SelectCityForm.dart';
import 'package:src/weather/WeatherDisplay.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    WeatherDto? weather = context.watch<WeatherProvider>().weatherDto;

    Widget weatherDisplay;

    if(weather == null){
      weatherDisplay = const Text("");
    }else{
      weatherDisplay = const WeatherDisplay();
    }

    return StartScaffold(
        title: "Weather Page",
        actions: const [
          UserOptions(),
        ],
        child: Column(
          children: [
            const SelectCityForm(),
            weatherDisplay
          ],
        )
    );
  }
}
