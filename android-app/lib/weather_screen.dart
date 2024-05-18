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
      firstDate: DateTime(2021),
      lastDate: DateTime(2027),
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
      return [];
    }
  }

  Future<Map<String, dynamic>> getCoordinates(String cityName) async {
    var apiKey = '9b23fa2e3b11b6dfe4dafc744dc9c77f';
    var url = Uri.parse(
        'https://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return {'lat': data[0]['lat'], 'lon': data[0]['lon']};
      } else {
        throw Exception('City not found');
      }
    } else {
      throw Exception('Failed to fetch coordinates');
    }
  }

  Future<List<dynamic>> getWeatherForCity(
      String cityName, String apiKey) async {
    try {
      // Get the coordinates of the city
      Map<String, dynamic> coordinates = await getCoordinates(cityName);
      double latitude = coordinates['lat'];
      double longitude = coordinates['lon'];

      // Use the coordinates to get the weather forecast
      var url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['list'];
        List<dynamic> forecasts = data
            .map((item) => {
                  'date': item['dt_txt'],
                  'max_temp': item['main']['temp_max'],
                  'mean_temp': item['main']['feels_like'],
                  'min_temp': item['main']['temp_min'],
                  'rain_chance': item['pop'] ?? 0.0,
                  'wind_speed': item['wind']['speed'] ?? 0.0,
                })
            .toList();
        return forecasts;
      } else {
        throw Exception('Failed to fetch weather forecast');
      }
    } catch (e) {
      print('An error occurred: $e');
      rethrow;
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
                  if (_cityController.text == 'cairo' ||
                      _cityController.text == 'sharm' ||
                      _cityController.text == 'aswan' ||
                      _cityController.text == 'alex' ||
                      _cityController.text == 'zagazig') {
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
                  } else {
                    final prediction = await getWeatherForCity(
                        _cityController.text,
                        '9b23fa2e3b11b6dfe4dafc744dc9c77f');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ShowWeather(weatherPredictions: prediction),
                      ),
                    );
                  }
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
