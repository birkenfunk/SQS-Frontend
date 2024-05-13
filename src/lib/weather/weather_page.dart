
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:src/components/start_scafold.dart';
import 'package:src/components/user_options.dart';
import 'package:src/entities/weather_dto.dart';
import 'package:src/services/providers/weather_provider.dart';
import 'package:src/weather/select_city_form.dart';
import 'package:src/weather/weather_display.dart';

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

    Size size = MediaQuery.of(context).size;
    double height = size.height;


    return StartScaffold(
        title: "Weather Page",
        actions: const [
          UserOptions(),
        ],
        child: Column(
          children: [
            const SelectCityForm(),
            SizedBox(
              height: height-220,
              width: 400,
              child: weatherDisplay,
            )
          ],
        )
    );
  }
}
