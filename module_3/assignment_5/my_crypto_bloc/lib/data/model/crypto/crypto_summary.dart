class CryptoSummary {
  final String id;
  final String symbol;
  final String name;
  final double? currentPriceMyr;
  final String logoUrl;

  CryptoSummary({
    required this.id,
    required this.symbol,
    required this.name,
    this.currentPriceMyr,
    required this.logoUrl,
  });

  CryptoSummary.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        symbol = json['symbol'] as String,
        name = json['name'] as String,
        currentPriceMyr = (json['current_price'] as num).toDouble(),
        logoUrl = json['image'] as String;

  CryptoSummary.fromSearchJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        symbol = json['symbol'] as String,
        name = json['name'] as String,
        logoUrl = json['thumb'] as String,
        currentPriceMyr = null;
}
