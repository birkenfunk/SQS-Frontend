import 'package:flutter/cupertino.dart';
import 'package:src/components/StartScafold.dart';
import 'package:src/components/UserOptions.dart';
import 'package:src/weather/SelectCityForm.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return const StartScaffold(
        title: "Weather Page",
        actions: [
          UserOptions(),
        ],
        child: SelectCityForm()
    );
  }
}
