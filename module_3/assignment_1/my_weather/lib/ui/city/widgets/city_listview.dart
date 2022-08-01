import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_weather/data/data.dart';
import 'package:my_weather/data/model/city.dart';
import 'package:my_weather/ui/weather/weather_screen.dart';

class CityListView extends StatefulWidget {
  const CityListView({super.key});

  @override
  State<CityListView> createState() => _CityListViewState();
}

class _CityListViewState extends State<CityListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: continents.length,
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
                    // Continent name & avatar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          continents[index]['name']!,
                          style: const TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                        CircleAvatar(
                          radius: 21,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              continents[index]['avatarUrl']!,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Divider(color: Colors.black),

                    // Cities chips
                    FutureBuilder(
                      future: loadCityList(continents[index]['assetsPath']!),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text(
                              'An error has occured during cities data loading.',
                            );
                          }

                          // Normal case
                          List<City> cities = snapshot.data as List<City>;
                          return Wrap(
                            children: List.generate(
                              cities.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ActionChip(
                                  backgroundColor: Colors.white,
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

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // Load city list from local assets
  Future<List<dynamic>> loadCityList(String resourcePath) async {
    var jsonText = await rootBundle.loadString(resourcePath);
    final List raw = json.decode(jsonText);
    List<City> cities = raw.map((data) => City.fromJson(data)).toList();
    return cities;
  }
}
