import 'city.dart';

class Continent {
  final String name;
  final String avatarUrl;
  final List<City> cities;

  Continent(
      {required this.name, required this.avatarUrl, required this.cities});

  Continent.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        avatarUrl = json['avatarUrl'],
        cities = List<City>.from(
          json['cities'].map(
            (cityJson) => City.fromJson(cityJson),
          ),
        );
}
