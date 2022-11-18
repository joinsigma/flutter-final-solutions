import 'package:my_weather/data/model/weather.dart';
import 'package:my_weather/data/network/rest_api_service.dart';

class WeatherRepository {
  final RestApiService _restApiService;

  WeatherRepository(this._restApiService);

  WeatherRepository.empty() : _restApiService = RestApiService();

  Future<Weather> getWeatherByCityId(String cityId) async {
    final result = await _restApiService.getWeatherByCityId(cityId);
    return await Future.delayed(const Duration(seconds: 2),(){return result;});
    // return result;
  }
}
