import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Untuk mendapatkan lokasi pengguna
import 'package:weathering/models/weather_model.dart';
import 'package:weathering/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("5e509ac28ec047bd3b783d5ab419bf32");
  Weather? _weather;

  // Fetch weather berdasarkan koordinat lokasi pengguna
  _fetchWeather() async {
    try {
      // Dapatkan lokasi saat ini (latitude & longitude)
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

      // Panggil API menggunakan latitude & longitude
      final weather = await _weatherService.getWeather(position.latitude, position.longitude);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch weather saat aplikasi dimulai
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_weather == null) Text("Loading location and temperature...", style: TextStyle(fontSize: 20)),
          if (_weather != null) ...[
            // Tampilkan nama kota atau status loading
            Text(
              _weather!.cityName ?? "Unknown location",
              style: TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 16),

            // Tampilkan suhu atau status loading
            Text(
              "${_weather!.temperature.round()}°C",
              style: TextStyle(fontSize: 20),
            ),
          ]
        ],
      ),
    );
  }
}
