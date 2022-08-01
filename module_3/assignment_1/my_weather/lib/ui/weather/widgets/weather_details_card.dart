import 'package:flutter/material.dart';
import 'package:my_weather/data/data.dart';
import 'package:my_weather/data/model/weather.dart';
import 'package:my_weather/ui/weather/widgets/current_temperature_info.dart';
import 'package:my_weather/ui/weather/widgets/weather_info_text.dart';

class WeatherDetailsCard extends StatelessWidget {
  const WeatherDetailsCard({
    Key? key,
    required this.weatherDetails,
  }) : super(key: key);

  final Weather weatherDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(weatherImages[weatherDetails.iconId]!),
          fit: BoxFit.fill,
          opacity: 0.90,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 30.0,
          ),
          child: Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // City name
                  Text(
                    weatherDetails.cityName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                    ),
                  ),

                  const Divider(),

                  // Weather avatar, condition & description
                  ListTile(
                    contentPadding: const EdgeInsets.all(0.0),
                    leading: CircleAvatar(
                      radius: 21,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'http://openweathermap.org/img/wn/${weatherDetails.iconId}.png',
                        ),
                        backgroundColor: Colors.blue[300],
                      ),
                    ),
                    title: Text(weatherDetails.mainWeather),
                    subtitle: Text(weatherDetails.description),
                  ),

                  const Divider(),

                  // Temperature settings
                  CurrentTemperatureInfo(weatherDetails: weatherDetails),
                  const SizedBox(height: 15.0),

                  WeatherInfoText(
                    label: 'Min: ',
                    textValue: '${weatherDetails.minTemp} \u2103',
                  ),
                  const SizedBox(height: 2.0),

                  WeatherInfoText(
                    label: 'Max: ',
                    textValue: '${weatherDetails.maxTemp} \u2103',
                  ),
                  const SizedBox(height: 2.0),

                  WeatherInfoText(
                    label: 'Feels Like: ',
                    textValue: '${weatherDetails.feelsLikeTemp} \u2103',
                  ),
                  const SizedBox(height: 2.0),

                  WeatherInfoText(
                    label: 'Humidity: ',
                    textValue: '${weatherDetails.humidity} %',
                  ),
                  const SizedBox(height: 2.0),

                  WeatherInfoText(
                    label: 'Pressure: ',
                    textValue: '${weatherDetails.pressure} hPa',
                  ),
                  const SizedBox(height: 2.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
