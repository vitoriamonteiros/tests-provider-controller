import 'package:flutter/material.dart';
import 'package:flutter_application_4/provider/weather_provider.dart';


class WeatherController extends ChangeNotifier {
  String description = '';
  int temp = 0;

  final WeatherProvider provider;

  WeatherController({required this.provider});

  Future getWeatherApi(String cityName) async {
    try {
      var codeCity = await provider.getRequestCodeCity(cityName);
      var json = await provider.getRequestWeather(codeCity!);

      description = json?.data['results']['description'];
      temp = json?.data['results']['temp'];
      notifyListeners();
    } catch (e) {
      print(e);
    } 
  }
}
