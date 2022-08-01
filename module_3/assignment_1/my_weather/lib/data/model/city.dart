class City {
  final int id;
  final String name;
  final String? state;
  final String? countryCode;
  final Map<String, dynamic> coordinates;

  City({
    required this.id,
    required this.name,
    required this.coordinates,
    this.state,
    this.countryCode,
  });

  City.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        state = json['state'] as String,
        countryCode = json['country'] as String,
        coordinates = json['coord'] as Map<String, dynamic>;
}
