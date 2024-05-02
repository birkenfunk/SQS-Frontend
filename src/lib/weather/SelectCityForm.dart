import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/entities/weather_dto.dart';
import 'package:src/services/api/weather_api_i.dart';
import 'package:src/services/providers/ApiProvider.dart';
import 'package:src/services/providers/WeatherProvider.dart';

class SelectCityForm extends StatefulWidget {
  const SelectCityForm({super.key});

  @override
  State<SelectCityForm> createState() => _SelectCityFormState();
}

class _SelectCityFormState extends State<SelectCityForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _city = '';

  changeCity(ApiProvider apiProvider, WeatherProvider weatherProvider) async{
    WeatherDto? weatherDto = await apiProvider.api?.getWeather(_city);
    weatherProvider.weatherDto = weatherDto;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        //half of page
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  key: const Key('select_city_input'),
                  decoration: const InputDecoration(
                    hintText: 'City',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a city';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _city = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      changeCity(context.read<ApiProvider>(), context.read<WeatherProvider>());
                    }
                  },
                  child: const Text('Get Weather'),
                ),
              ],
            )));
  }
}
