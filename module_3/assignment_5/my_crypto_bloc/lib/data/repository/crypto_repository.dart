import 'package:my_crypto_bloc/data/model/crypto/crypto_details.dart';
import 'package:my_crypto_bloc/data/model/crypto/crypto_summary.dart';
import 'package:my_crypto_bloc/data/network/rest_api_service.dart';

class CryptoRepository {
  final RestApiService _restApiService;

  CryptoRepository(this._restApiService);

  CryptoRepository.empty() : _restApiService = RestApiService();

  // Get homepage crypto summary
  Future<List<CryptoSummary>> getHomePageCrypto() async {
    final result = await _restApiService.getHomePageCrypto();
    return result;
  }

  // Search crypto by keyword
  Future<List<CryptoSummary>> searchCryptoByKeyword(String keyword) async {
    final result = await _restApiService.searchCryptoByKeyword(keyword);
    return result;
  }

  // Get crypto details by id
  Future<CryptoDetails> getCryptoDetailsById(String cryptoId) async {
    final result = await _restApiService.getCryptoDetailsById(cryptoId);
    return result;
  }
}
