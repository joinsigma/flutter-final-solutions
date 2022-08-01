import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_weather/data/model/weather.dart';

class CurrentTemperatureInfo extends StatelessWidget {
  const CurrentTemperatureInfo({
    Key? key,
    required this.weatherDetails,
  }) : super(key: key);

  final Weather weatherDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${weatherDetails.currentTemp} \u2103',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Updated ${DateFormat('hh:mm aa').format(weatherDetails.lastUpdateTime)}',
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const Text(
                'Current Temperature',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
