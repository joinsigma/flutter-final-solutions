import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_weather/data/data.dart';
import 'package:my_weather/data/model/city.dart';
import 'package:my_weather/data/model/continent.dart';
import 'package:my_weather/ui/weather/weather_screen.dart';

class CityListView extends StatefulWidget {
  const CityListView({super.key});

  @override
  State<CityListView> createState() => _CityListViewState();
}

class _CityListViewState extends State<CityListView> {
  late List<Continent> data;

  @override
  void initState() {
    //Convert from json to data objects
    data = List<Continent>.from(
      continentsAndCitiesData.map(
        (json) => Continent.fromJson(json),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: ((context, index) {
        return SizedBox(
          width: double.infinity,
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[100],
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContinentSection(data[index]),
                    const Divider(color: Colors.black),
                    _buildCitiesChip(data[index].cities)
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContinentSection(Continent continent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          continent.name,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        CircleAvatar(
          radius: 21,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              continent.avatarUrl,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCitiesChip(List<City> cities) {
    return Wrap(
      children: List.generate(
        // data.length,
        cities.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: ActionChip(
            backgroundColor: Colors.white,
            // label: Text(cities[index].name),
            label: Text(cities[index].name),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WeatherScreen(
                    cityId: cities[index].id.toString(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Load city list from local assets
  // Future<List<dynamic>> loadCityList(String resourcePath) async {
  //   var jsonText = await rootBundle.loadString(resourcePath);
  //   final List raw = json.decode(jsonText);
  //   List<City> cities = raw.map((data) => City.fromJson(data)).toList();
  //   return cities;
  // }
}
