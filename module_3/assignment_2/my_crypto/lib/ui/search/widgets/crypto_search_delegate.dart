import 'package:flutter/material.dart';
import 'package:my_crypto/data/model/crypto/crypto_summary.dart';
import 'package:my_crypto/data/repository/crypto_repository.dart';
import 'package:my_crypto/ui/details/crypto_details_screen.dart';

class CoinSearchDelegate extends SearchDelegate {
  // Build the action 'clear text [ X ]' button on search page
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      ),
    ];
  }

  // Build the leading 'back' button on search page
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.length >= 3
        ? FutureBuilder(
            future: CryptoRepository.empty().searchCryptoByKeyword(query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error searching coins'),
                  );
                }

                List<CryptoSummary> cryptos = snapshot.data!;
                return ListView.builder(
                  itemCount: cryptos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cryptos[index].name),
                      leading: CircleAvatar(
                        radius: 16.0,
                        backgroundImage: NetworkImage(
                          cryptos[index].logoUrl,
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CryptoDetailsScreen(
                            cryptoId: cryptos[index].id,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        : Container();
  }
}
