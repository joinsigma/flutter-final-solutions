import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_restaurant/data/model/restaurant_summary.dart';
import 'package:my_restaurant/ui/details/restaurant_details_screen.dart';
import 'package:my_restaurant/ui/search/bloc/search_restaurant_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_restaurant/ui/search/bloc/search_restaurant_event.dart';
import 'package:my_restaurant/ui/search/bloc/search_restaurant_state.dart';

class SearchRestaurantScreen extends StatefulWidget {
  final String location;

  const SearchRestaurantScreen({
    required this.location,
    super.key,
  });

  @override
  State<SearchRestaurantScreen> createState() => _SearchRestaurantScreenState();
}

class _SearchRestaurantScreenState extends State<SearchRestaurantScreen> {
  late SearchRestaurantBloc _searchRestaurantBloc;

  @override
  void initState() {
    _searchRestaurantBloc =
        kiwi.KiwiContainer().resolve<SearchRestaurantBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _searchRestaurantBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchRestaurantBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search in ${widget.location}'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter keyword to search:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 50.0,
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0.0),
                      prefixIcon: const Icon(Icons.search_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      hintText: 'Eg. Bakery, Noodles...'),
                  onChanged: (value) {
                    if (value.isNotEmpty && value.length > 2) {
                      _searchRestaurantBloc.add(
                        TriggerSearch(widget.location, value),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 32.0),
              BlocBuilder<SearchRestaurantBloc, SearchRestaurantState>(
                builder: (context, state) {
                  if (state is SearchRestaurantLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SearchRestaurantFailed) {
                    return Center(child: Text(state.errorMsg));
                  } else if (state is SearchRestaurantSuccessful) {
                    final List<RestaurantSummary> restaurants =
                        state.restaurants;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  restaurants[index].imageUrl.isNotEmpty
                                      ? NetworkImage(
                                          restaurants[index].imageUrl,
                                        )
                                      : null,
                            ),
                            title: Text(restaurants[index].name),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${restaurants[index].rating} \u2605'),
                                Text(
                                    '${restaurants[index].reviewCount} reviews'),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RestaurantDetailsScreen(
                                    restaurantId: restaurants[index].id,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
