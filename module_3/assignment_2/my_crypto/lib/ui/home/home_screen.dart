import 'package:flutter/material.dart';
import 'package:my_crypto/data/model/crypto/crypto_summary.dart';
import 'package:my_crypto/data/repository/crypto_repository.dart';
import 'package:my_crypto/ui/search/widgets/crypto_search_delegate.dart';
import 'package:my_crypto/ui/home/widgets/crypto_summary_listtile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Crypto'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GestureDetector(
              child: const Icon(Icons.search),
              onTap: () {
                showSearch(context: context, delegate: CoinSearchDelegate());
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
        child: FutureBuilder(
          future: CryptoRepository.empty().getHomePageCrypto(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error getting Homepage coins'),
                );
              }

              // Normal case
              List<CryptoSummary> cryptos = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Text
                  const Text(
                    'Popular Coins',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 24.0),
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

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
