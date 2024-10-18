import 'dart:convert';

import 'package:weathering/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/3.0/weather/";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Url.parse("$BASE_URL?q=$cityName&appid=$apiKey&units=metric"));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonEncode(response.body));
    } else {
      throw Exception('Failded to load weather adata');
    }
  }
}
