import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:travel_app/ui/detail/detail_screen.dart';
import 'package:travel_app/ui/search/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc _searchBloc;
  late TextEditingController _searchCtrl;

  @override
  void initState() {
    _searchBloc = kiwi.KiwiContainer().resolve<SearchBloc>();
    _searchCtrl = TextEditingController();
    _searchCtrl.addListener(() {
      if (_searchCtrl.text.length > 4) {
        _searchBloc.add(TriggerSearch(_searchCtrl.text));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchBloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                autofocus: true,
                controller: _searchCtrl,
                decoration: InputDecoration(
                    prefixIcon: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios))),
              ),
            ),
            BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
              if (state is SearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchLoadSuccess) {
                return state.packages.isEmpty
                    ? const Text('No result found')
                    : Expanded(
                        child: ListView.builder(
                          itemCount: state.packages.length,
                          itemBuilder: (context, index) {
                            final package = state.packages[index];
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            id: package.id,
                                            title: package.title)));
                              },
                              title: Text(package.title),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(package.imgUrl),
                              ),
                              subtitle: Text(package.location),
                              trailing: Text('RM${package.price}/person'),
                            );
                          },
                        ),
                  
                      );
              } else {
                return Text('Search Error');
              }
            })
          ]),
        ),
      ),
    );
  }
}
