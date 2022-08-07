import 'package:my_crypto/data/data.dart';
import 'package:my_crypto/data/model/crypto/crypto_details.dart';
import 'package:my_crypto/data/model/crypto/crypto_summary.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestApiService {
  final String baseLink = 'https://api.coingecko.com/api/v3';

  /// API call to get homepage crypto
  ///
  Future<List<CryptoSummary>> getHomePageCrypto() async {
    // Join the List so that bracket [] will not be included as coin ids
    final String coinIds = homepageCoinsIds.join(',');

    final requestUri = Uri.parse(
      '$baseLink/coins/markets?vs_currency=myr&ids=$coinIds',
    );
    final response = await http.get(requestUri);

    if (response.statusCode == 200) {
      final List raw = jsonDecode(response.body);

      List<CryptoSummary> cryptos =
          raw.map((data) => CryptoSummary.fromJson(data)).toList();
      return cryptos;
    } else {
      throw Exception('API Error getting homepage coins summary');
    }
  }

  /// Search coins
  Future<List<CryptoSummary>> searchCryptoByKeyword(String keyword) async {
    final requestUri = Uri.parse(
      '$baseLink/search?query=$keyword',
    );

    final response = await http.get(requestUri);

    if (response.statusCode == 200) {
      final List raw = jsonDecode(response.body)['coins'];
      List<CryptoSummary> cryptos = raw.map((crypto) => CryptoSummary.fromSearchJson(crypto)).toList();
      return cryptos;
    } else {
      throw Exception('API Error when searching coins');
    }
  }

  /// Get coins details
  Future<CryptoDetails> getCryptoDetailsById(String cryptoId) async {
    final requestUri = Uri.parse('$baseLink/coins/$cryptoId');
    final response = await http.get(requestUri);

    if (response.statusCode == 200) {
      final raw = jsonDecode(response.body);
      return CryptoDetails.fromJson(raw);
    } else {
      throw Exception('API Error getting crypto details by cryptoId: $cryptoId');
    }
  }
}
