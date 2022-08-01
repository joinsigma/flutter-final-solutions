import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_weather/data/model/weather.dart';

class RestApiService {
  static const String baseLink = 'https://api.openweathermap.org/data/2.5/weather';
  static const String apiKey = 'd6151141037a0904532e90dec78c9814';

  /// API call for get weather by city id
  /// 
  Future<Weather> getWeatherByCityId(String cityId) async {
    final response = await http.get(
      Uri.parse('$baseLink?units=metric&appid=$apiKey&id=$cityId')
    );

    if (response.statusCode == 200) {
      final raw = jsonDecode(response.body);
      return Weather.fromJson(raw);
    } else {
      throw Exception('Failed to get weather for cityId: $cityId');
    }
  }
}