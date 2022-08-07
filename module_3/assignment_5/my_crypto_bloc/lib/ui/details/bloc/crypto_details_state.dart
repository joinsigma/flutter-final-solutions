import 'package:equatable/equatable.dart';
import 'package:my_crypto_bloc/data/model/crypto/crypto_details.dart';

/// Todo 12: Prepare bloc states for getCryptoDetails feature
/// 
/// - create an abstract class [ CryptoDetailsState ] extends [ Equatable ]
/// - States: [ CryptoDetailsLoading ], [ CryptoDetailsLoaded ], [ CryptoDetailsFailed ]

abstract class CryptoDetailsState extends Equatable {}

class CryptoDetailsLoading extends CryptoDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoDetailsLoaded extends CryptoDetailsState {
  final CryptoDetails cryptoDetails;

  CryptoDetailsLoaded(this.cryptoDetails);

  @override
  List<Object?> get props => [cryptoDetails];
}

class CryptoDetailsFailed extends CryptoDetailsState {
  final String errorMsg;

  CryptoDetailsFailed(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
