import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    WeatherApiI api = WeatherApiI.create(_serverHost, _serverPort, _useHttps);

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
    return SizedBox(
        //half of page
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: DropdownButtonFormField(
                        alignment: Alignment.centerLeft,
                          items: const [
                            DropdownMenuItem(
                              value: false,
                              child: Text('http'),
                            ),
                            DropdownMenuItem(
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
                      width: 200,
                      child: TextFormField(
                        initialValue: _serverHost,
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
                      width: 100,
                      child: TextFormField(
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
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      next(context.read<ApiProvider>());
                    }
                  },
                  child: const Text('Next'),
                ),
              ],
            )));
  }
}
