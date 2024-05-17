import 'package:flutter/material.dart';

class ShowWeather extends StatelessWidget {
  final List<dynamic> weatherPredictions;

  const ShowWeather({super.key, required this.weatherPredictions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Predictions'),
      ),
      body: ListView.builder(
        itemCount: weatherPredictions.length,
        itemBuilder: (context, index) {
          final prediction = weatherPredictions[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${prediction['date']}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Max Temp: ${prediction['max_temp']}°C'),
                  Text('Mean Temp: ${prediction['mean_temp']}°C'),
                  Text('Min Temp: ${prediction['min_temp']}°C'),
                  Text('Rain Chance: ${prediction['rain_chance']}%'),
                  Text('Wind Speed: ${prediction['wind_speed']} km/h'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
