import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/detail/detail_screen.dart';
import 'package:travel_app/ui/home/home_bloc.dart';
import 'package:travel_app/ui/home/widgets/travel_package_card.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:travel_app/ui/search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;
  @override
  void initState() {
    _homeBloc = kiwi.KiwiContainer().resolve<HomeBloc>();
    _homeBloc.add(LoadPackages());
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeBloc,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // enabled: false,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>const SearchScreen()));
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                    ),
                  ),
                  prefixIcon: Icon(Icons.search),
                  label: Text('Search'),
                ),
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is HomeLoading) {
                return const CircularProgressIndicator();
              } else if (state is HomeLoadSuccess) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.packages.length,
                      itemBuilder: (context, index) {
                        final package = state.packages[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  id: package.id,
                                  title: package.title,
                                ),
                              ),
                            );
                          },
                          child: TravelPackageCard(
                              title: package.title,
                              isFavourite: true,
                              tags: package.tags,
                              imgUrl: package.imgUrl,
                              price: package.price,
                              location: package.location),
                        );
                      }),
                );
              } else {
                ///Todo: Implement better error msg
                return const Text('Error');
              }
            })
          ],
        ),
      ),
    );
  }
}
