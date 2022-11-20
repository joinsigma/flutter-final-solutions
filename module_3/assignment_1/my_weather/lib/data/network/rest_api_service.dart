import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:my_weather/data/model/weather.dart';

///Create api_key.dart file at the root of lib/ folder.
///Create a constant variable as follows and assign to your API_KEY.
///const WEATHER_API_KEY = '2777xxxxxxxx';
///Insert /lib/api_key.dart in .gitignore to hide your API key from version control (Github).
import 'package:my_weather/api_key.dart';

class RestApiService {
  static const String baseLink =
      'https://api.openweathermap.org/data/2.5/weather';

  /// API call for get weather by city id
  Future<Weather> getWeatherByCityId(String cityId) async {
    final response = await http.get(
        Uri.parse('$baseLink?units=metric&appid=$WEATHER_API_KEY&id=$cityId'));
    if (response.statusCode == 200) {
      final raw = jsonDecode(response.body);
      return Weather.fromJson(raw);
    } else {
      throw Exception('Failed to get weather for cityId: $cityId');
    }
  }
}
