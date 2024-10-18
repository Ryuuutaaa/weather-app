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

  // weather animmation

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
