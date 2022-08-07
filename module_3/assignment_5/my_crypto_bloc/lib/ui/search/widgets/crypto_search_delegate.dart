import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_crypto_bloc/data/model/crypto/crypto_summary.dart';
import 'package:my_crypto_bloc/ui/details/crypto_details_screen.dart';
import 'package:my_crypto_bloc/ui/search/bloc/search_crypto_bloc.dart';
import 'package:my_crypto_bloc/ui/search/bloc/search_crypto_event.dart';
import 'package:my_crypto_bloc/ui/search/bloc/search_crypto_state.dart';

/// Todo 18: Implement search crypto bloc
class CoinSearchDelegate extends SearchDelegate {
  final SearchCryptoBloc _searchCryptoBloc;

  CoinSearchDelegate(this._searchCryptoBloc);

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
    return query.length >= 3 ? buildSuggestionResult(context) : Container();
  }

  BlocBuilder buildSuggestionResult(BuildContext context) {
    // Trigger searchByKeyword
    _searchCryptoBloc.add(SearchCryptoByKeyword(query));

    return BlocBuilder<SearchCryptoBloc, SearchCryptoState>(
      bloc: _searchCryptoBloc,
      builder: (context, state) {
        if (state is SearchResultsLoading) {
          return buildLoading();
        } else if (state is SearchResultsFailed) {
          return buildError(state);
        } else if (state is SearchResultsLoaded) {
          final List<CryptoSummary> searchResults = state.cryptos;
          return buildSearchResultsListView(searchResults);
        }
        return Container();
      },
    );
  }

  Center buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Center buildError(SearchResultsFailed state) {
    return Center(
      child: Text(state.errorMsg),
    );
  }

  ListView buildSearchResultsListView(List<CryptoSummary> searchResults) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].name),
          leading: CircleAvatar(
            radius: 16.0,
            backgroundImage: NetworkImage(
              searchResults[index].logoUrl,
            ),
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CryptoDetailsScreen(
                cryptoId: searchResults[index].id,
              ),
            ),
          ),
        );
      },
    );
  }
}
