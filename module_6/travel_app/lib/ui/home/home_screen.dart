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
              padding:
                  const EdgeInsets.only(top: 8.0, left: 16.0,right: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(30),
                    // border: Border.all(color: Colors.orangeAccent),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen()));
                    },
                    child: const TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.orange,
                          ),
                          label: Text(
                            'Where do you want to travel ?',
                            style: TextStyle(color: Colors.orange),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never
                          // helperText: 'Search'
                          ),
                    ),
                  ),
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
