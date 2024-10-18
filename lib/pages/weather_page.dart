import 'package:flutter/material.dart';
import 'package:weathering/models/weather_model.dart';
import 'package:weathering/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService(apiKey);
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any error
    catch (e) {
      print(e);
    }
  }

  // weather animmation

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
