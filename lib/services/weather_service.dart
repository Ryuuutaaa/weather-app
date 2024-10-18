import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weathering/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  // Gunakan endpoint One Call API
  static const BASE_URL = "https://api.openweathermap.org/data/3.0/onecall";
  final String apiKey;

  WeatherService(this.apiKey);

  // Mendapatkan cuaca berdasarkan koordinat (latitude, longitude)
  Future<Weather> getWeather(double lat, double lon) async {
    // Exclude minutely dan hourly data jika tidak dibutuhkan
    final exclude = "minutely,hourly";
    final response = await http.get(Uri.parse("$BASE_URL?lat=$lat&lon=$lon&exclude=$exclude&appid=$apiKey&units=metric"));

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }
}
