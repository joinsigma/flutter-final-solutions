import 'package:flutter/material.dart';
import 'package:my_weather/data/model/weather.dart';
import 'package:my_weather/data/network/rest_api_service.dart';
import 'package:my_weather/data/repository/weather_repository.dart';
import 'package:my_weather/ui/weather/widgets/weather_details_card.dart';

class WeatherScreen extends StatefulWidget {
  final String cityId;

  const WeatherScreen({
    super.key,
    required this.cityId,
  });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  RestApiService restApiService = RestApiService();
  final WeatherRepository _weatherRepository = WeatherRepository.empty();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather Details'),
        ),
        body: FutureBuilder(
          future: _weatherRepository.getWeatherByCityId(widget.cityId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text(
                  'An error has occurred during weather loading.',
                );
              }

              Weather weatherDetails = snapshot.data!;
              return WeatherDetailsCard(weatherDetails: weatherDetails);
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
