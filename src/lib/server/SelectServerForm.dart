import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/services/api/weather_api.dart';
import 'package:src/services/api/weather_api_i.dart';
import 'package:src/services/providers/ApiProvider.dart';

class SelectServerForm extends StatefulWidget {
  const SelectServerForm({super.key});

  @override
  State<SelectServerForm> createState() => _SelectServerFormState();
}

class _SelectServerFormState extends State<SelectServerForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _error = '';
  String _serverHost = 'localhost';
  bool _useHttps = false;
  int _serverPort = 4000;

  next(ApiProvider apiProvider) async {
    WeatherApiI api = WeatherFactory.create(_serverHost, _serverPort, _useHttps);

    bool? isValid = await api.isHealthy();
    if (isValid == null || !isValid) {
      setState(() {
        _error = 'Server not reachable';
      });
      return;
    } else {
      apiProvider.api = api;
      setState(() {
        Navigator.pushNamed(context, '/weather');
        _error = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 200;
    if (width < 0 || width > 400) {
      width = 400;
    }
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 105,
                  child: DropdownButtonFormField(
                      key: const Key('protocolDropdown_serverForm'),
                      alignment: Alignment.centerLeft,
                      items: const [
                        DropdownMenuItem(
                          key: Key('httpDropdownItem_serverForm'),
                          value: false,
                          child: Text('http'),
                        ),
                        DropdownMenuItem(
                          key: Key('httpsDropdownItem_serverForm'),
                          value: true,
                          child: Text('https'),
                        ),
                      ],
                      value: _useHttps,
                      onChanged: (bool? value) {
                        setState(() {
                          _useHttps = value!;
                        });
                      }),
                ),
                const Text('://'),
                SizedBox(
                  width: width,
                  child: TextFormField(
                    key: const Key('hostInput_serverForm'),
                    initialValue: _serverHost,
                    keyboardType: TextInputType.url,
                    decoration: const InputDecoration(
                      hintText: 'Enter host',
                    ),
                    validator: (String? value) {
                      //check if url is valid
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid url';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        _serverHost = value;
                      });
                    },
                  ),
                ),
                const Text(':'),
                SizedBox(
                  width: 60,
                  child: TextFormField(
                    key: const Key('portInput_serverForm'),
                    keyboardType: TextInputType.number,
                    initialValue: _serverPort.toString(),
                    decoration: const InputDecoration(
                      hintText: 'Enter port',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        _serverPort = int.parse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              _error,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              key: const Key('nextButton_serverForm'),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  next(context.read<ApiProvider>());
                }
              },
              child: const Text('Next'),
            ),
          ],
        ));
  }
}
