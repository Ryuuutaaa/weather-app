import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weathering/models/weather_model.dart';

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/3.0/onecall";
  final String apiKey;

  WeatherService(this.apiKey);

  // Mendapatkan cuaca berdasarkan latitude dan longitude
  Future<Weather> getWeather(double lat, double lon) async {
    final exclude = "minutely,hourly"; // Kamu bisa mengatur sesuai kebutuhan
    final response = await http.get(Uri.parse("$BASE_URL?lat=$lat&lon=$lon&exclude=$exclude&appid=$apiKey&units=metric"));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  // Mendapatkan latitude dan longitude berdasarkan lokasi saat ini
  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied, we cannot request permissions.");
    }

    // Mendapatkan posisi saat ini
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
