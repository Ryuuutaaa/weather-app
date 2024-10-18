import 'package:flutter/material.dart';
import 'package:weathering/models/weather_model.dart';
import 'package:weathering/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API key
  final _weatherService = WeatherService("5e509ac28ec047bd3b783d5ab419bf32");
  Weather? _weather;

  // Fetch weather
  _fetchWeather() async {
    // Get current city
    String cityName = await _weatherService.getCurrentCity();

    // Get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // Init state
  @override
  void initState() {
    super.initState();
    // Fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // City name
          Text(
            _weather?.cityName ?? "Loading city...",
            style: TextStyle(fontSize: 24),
          ),

          const SizedBox(height: 16),

          // Temperature
          Text(
            _weather != null
                ? "${_weather!.temperature.round()}°C" // Use ! to safely access temperature
                : "Loading temperature...",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
