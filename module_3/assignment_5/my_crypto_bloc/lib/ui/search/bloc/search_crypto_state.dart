import 'package:equatable/equatable.dart';
import 'package:my_crypto_bloc/data/model/crypto/crypto_summary.dart';

/// Todo 9: Prepare bloc states for Search crypto feature
/// 
/// - create an abstract class [ SearchCryptoState ] extends [ Equatable ]
/// - States: [ SearchResultsLoading ], [ SearchResultsLoaded ], [ SearchResultsFailed ]

abstract class SearchCryptoState extends Equatable {}

class SearchResultsLoading extends SearchCryptoState {
  @override
  List<Object?> get props => [];
}

class SearchResultsLoaded extends SearchCryptoState {
  final List<CryptoSummary> cryptos;

  SearchResultsLoaded(this.cryptos);

  @override
  List<Object?> get props => [cryptos];
}

class SearchResultsFailed extends SearchCryptoState {
  final String errorMsg;

  SearchResultsFailed(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}