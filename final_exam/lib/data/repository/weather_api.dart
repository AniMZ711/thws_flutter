import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skylinq/utils/consts.dart';
import 'package:skylinq/data/models/current_weather.dart';
import 'package:skylinq/data/models/forecast.dart';

class WeatherAPI {
  final String apiKey = API_KEY;
  final String baseURL = "http://api.weatherapi.com/v1";

  Future<CurrentWeather> getCurrentWeather(String city) async {
    final response =
        await http.get(Uri.parse("$baseURL/current.json?key=$apiKey&q=$city"));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final currentWeather = CurrentWeather.fromJson(json);
      return currentWeather;
    } else {
      throw Exception("Failed to load weather data: ${response.body}");
    }
  }

  Future<Forecast> getForecast(String city, num days) async {
    final response = await http.get(
        Uri.parse("$baseURL/forecast.json?key=$apiKey&q=$city&days=$days"));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final forecast = Forecast.fromJson(json);
      return forecast;
    } else {
      throw Exception("Failed to load weather data: ${response.body}");
    }
  }
}
