class CryptoDetails {
  final String id;
  final String name;
  final String iconUrl;
  final String description;

  final double currentPriceMyr;
  final double allTimeHighMyr;
  final double allTimeLowMyr;

  final DateTime allTimeHighDate;
  final DateTime allTimeLowDate;

  final double highIn24Hour;
  final double lowIn24Hour;

  final DateTime lastUpdateTime;

  CryptoDetails({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.description,
    required this.currentPriceMyr,
    required this.allTimeHighMyr,
    required this.allTimeLowMyr,
    required this.allTimeHighDate,
    required this.allTimeLowDate,
    required this.highIn24Hour,
    required this.lowIn24Hour,
    required this.lastUpdateTime,
  });

  CryptoDetails.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
    name = json['name'] as String,
    iconUrl = json['image']['large'] as String,
    description = json['description']['en'] as String,
    currentPriceMyr = (json['market_data']['current_price']['myr'] as num).toDouble(),
    allTimeHighMyr = (json['market_data']['ath']['myr'] as num).toDouble(),
    allTimeLowMyr = (json['market_data']['atl']['myr'] as num).toDouble(),
    allTimeHighDate = DateTime.parse((json['market_data']['ath_date']['myr'] as String)),
    allTimeLowDate = DateTime.parse((json['market_data']['atl_date']['myr'] as String)),
    highIn24Hour = (json['market_data']['high_24h']['myr'] as num).toDouble(),
    lowIn24Hour = (json['market_data']['low_24h']['myr'] as num).toDouble(),
    lastUpdateTime = DateTime.parse((json['last_updated'] as String));
}
