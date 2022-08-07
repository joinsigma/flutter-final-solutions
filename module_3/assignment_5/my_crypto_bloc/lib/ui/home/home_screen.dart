import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_crypto_bloc/data/model/crypto/crypto_summary.dart';
import 'package:my_crypto_bloc/ui/search/widgets/crypto_search_delegate.dart';
import 'package:my_crypto_bloc/ui/home/widgets/crypto_summary_listtile.dart';
import 'package:my_crypto_bloc/ui/home/bloc/home_page_bloc.dart';
import 'package:my_crypto_bloc/ui/home/bloc/home_page_event.dart';
import 'package:my_crypto_bloc/ui/home/bloc/home_page_state.dart';
import 'package:my_crypto_bloc/ui/search/bloc/search_crypto_bloc.dart';

/// Todo 15: Implement Homepage Bloc using BlocProvider
/// - in [ main.dart ], invoke [ initKiwi() ]
/// - get bloc instance from kiwi container in initState()
/// - provide the [ HomepageBloc ] to the home screen
/// - replace the [ FutureBuilder ] with bloc implementation
///
/// - Steps:
///   1. Make HomeScreen a stateful widget
///   2. in [ initState() ], get an instance of [ HomepageBloc ] from kiwi container
///   3. provide the [ HomepageBloc ] to the screen
///   4. in [ initState() ] also, trigger the API that load the home page crypto
///   5. use [ BlocBuilder ] to rebuild the widget based on the bloc states
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomepageBloc _homepageBloc;

  @override
  void initState() {
    _homepageBloc = kiwi.KiwiContainer().resolve<HomepageBloc>();

    _homepageBloc.add(GetHomepageCrypto());
    super.initState();
  }

  @override
  void dispose() {
    _homepageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomepageBloc>(
      create: (context) => _homepageBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Crypto'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GestureDetector(
                child: const Icon(Icons.search),
                onTap: () {
                  final searchCryptoBloc =
                      BlocProvider.of<SearchCryptoBloc>(context);
                  showSearch(
                    context: context,
                    delegate: CoinSearchDelegate(searchCryptoBloc),
                  );
                },
              ),
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 18.0,
          ),
          child: BlocBuilder<HomepageBloc, HomepageState>(
            builder: (context, state) {
              if (state is HomepageCryptoLoading) {
                return buildLoading();
              } else if (state is HomepageCryptoFailed) {
                return buildError(state);
              } else if (state is HomepageCryptoLoaded) {
                List<CryptoSummary> cryptos = state.cryptos;
                return buildHomepageCryptoListView(cryptos);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Column buildHomepageCryptoListView(List<CryptoSummary> cryptos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Text
        const Text(
          'Popular Coins',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.0),
        ),

        const SizedBox(height: 10.0),

        // Coins listview
        Expanded(
          child: ListView.builder(
            itemCount: cryptos.length,
            itemBuilder: ((context, index) {
              return Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: CryptoSummaryListTile(
                    crypto: cryptos[index],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Center buildError(HomepageCryptoFailed state) {
    return Center(
      child: Text(state.errorMsg),
    );
  }

  Center buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
