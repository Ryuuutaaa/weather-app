class Weather {
  final String cityName;
  final double temperature;
  final String mainConditional;

  Weather({required this.cityName, required this.temperature, required this.mainConditional});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json["name"],
      temperature: json["main"]["temp"].toDouble(),
      mainConditional: json["weather"][0]["main"],
    );
  }
}
