// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:weather_app/show_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  DateTime dateTime = DateTime.now();
  String formattedDate = "";
  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
      initialDate: DateTime.now(),
    ).then((value) {
      setState(() {
        dateTime = value!;
        formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
        print(formattedDate);
      });
    });
  }

  Future<List<dynamic>> fetchWeatherPrediction(String city, String date) async {
    var url = Uri.http('10.0.2.2:5000', '/', {'city': city, 'date': date});
    final response = await http.get(url);
    print(url);
    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    } else {
      throw Exception('Failed to load weather prediction');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Predictor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(hintText: 'Enter City Name'),
            ),
            const SizedBox(
              height: 16,
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: _showDatePicker,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Choose a Date',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final prediction = await fetchWeatherPrediction(
                    _cityController.text,
                    formattedDate,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ShowWeather(weatherPredictions: prediction),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Get Weather Prediction'),
            ),
          ],
        ),
      ),
    );
  }
}
