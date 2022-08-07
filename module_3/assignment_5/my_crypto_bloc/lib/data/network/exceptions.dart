/// Rest API service exceptions.

class GetHomepageCryptoException implements Exception {
  final String errorMsg;
  GetHomepageCryptoException(this.errorMsg);
}

class SearchCryptoException implements Exception {
  final String errorMsg;
  SearchCryptoException(this.errorMsg);
}

class GetCryptoDetailsException implements Exception {
  final String errorMsg;
  GetCryptoDetailsException(this.errorMsg);
}