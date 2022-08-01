class Weather {
  final int id;
  final String mainWeather;   // group of weather parameters (Rain, Snow, Extreme etc)
  final String description;   // weather condition of the group
  final String iconId;
  final String currentTemp;
  final String feelsLikeTemp;   // temperature accounts for the human perception
  final double pressure;  // atmosphere pressure (hPa)
  final double humidity;  // humidity (%)
  final String minTemp;   // minimum temp observed in large megalopolises at the moment
  final String maxTemp;   // maximum temp observed in large megalopolises at the moment

  final double visibility;    // visibility (meter)
  final int cityId;
  final String cityName;
  final DateTime lastUpdateTime;

  Weather({
    required this.id,
    required this.mainWeather,
    required this.description,
    required this.iconId,
    required this.currentTemp,
    required this.feelsLikeTemp,
    required this.pressure,
    required this.humidity,
    required this.minTemp,
    required this.maxTemp,
    required this.visibility,
    required this.cityId,
    required this.cityName,
    required this.lastUpdateTime,
  });

  Weather.fromJson(Map<String, dynamic> json) :
    id = json['weather'][0]['id'] as int,
    mainWeather = json['weather'][0]['main'] as String,
    description = json['weather'][0]['description'] as String,
    iconId = json['weather'][0]['icon'] as String,
    currentTemp = (json['main']['temp'] as num).toStringAsFixed(1),
    feelsLikeTemp = (json['main']['feels_like'] as num).toStringAsFixed(1),
    minTemp = (json['main']['temp_min'] as num).toStringAsFixed(1),
    maxTemp = (json['main']['temp_max'] as num).toStringAsFixed(1),
    pressure = (json['main']['pressure'] as num).toDouble() ,
    humidity = (json['main']['humidity'] as num).toDouble(),
    visibility = (json['visibility'] as num).toDouble(),
    cityId = json['id'] as int,
    cityName = json['name'] as String,
    lastUpdateTime = DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000);
}