import 'package:equatable/equatable.dart';
import 'package:my_crypto_bloc/data/model/crypto/crypto_summary.dart';

/// Todo 6: Prepare bloc states for Homepage
/// 
/// - create an abstract class [ HomepageState ] extends [ Equatable ]
/// - States: [ HomepageCryptoLoading ], [ HomepageCryptoLoaded ], [ HomepageCryptoFailed ]

abstract class HomepageState extends Equatable {}

class HomepageCryptoLoading extends HomepageState {
  @override
  List<Object?> get props => [];
}

class HomepageCryptoLoaded extends HomepageState {
  final List<CryptoSummary> cryptos;

  HomepageCryptoLoaded(this.cryptos);

  @override
  List<Object?> get props => [cryptos];
}

class HomepageCryptoFailed extends HomepageState {
  final String errorMsg;

  HomepageCryptoFailed(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}