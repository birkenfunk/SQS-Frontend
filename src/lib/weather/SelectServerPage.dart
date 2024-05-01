import 'package:flutter/cupertino.dart';
import 'package:src/compontents/StartScafold.dart';
import 'package:src/compontents/UserOptions.dart';
import 'package:src/server/SelectCityForm.dart';
import 'package:src/weather/SelectServerForm.dart';
class SelectServerPage extends StatefulWidget {
  const SelectServerPage({super.key});

  @override
  State<StatefulWidget> createState() => _SelectServerPageState();

}

class _SelectServerPageState extends State<SelectServerPage>{

  @override
  Widget build(BuildContext context) {
    return const StartScaffold(
      title: "Select Server",
      child: SelectServerForm(),
    );
  }
}