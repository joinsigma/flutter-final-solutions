import 'package:equatable/equatable.dart';

/// Todo 11: Prepare bloc events for GetCryptoDetails feature
/// 
/// - create an abstract class [ CryptoDetailsEvent ] extends [ Equatable ]
/// - Event: [ GetCryptoDetailsById ]

abstract class CryptoDetailsEvent extends Equatable {}

class GetCryptoDetailsById extends CryptoDetailsEvent {
  final String cryptoId;

  GetCryptoDetailsById(this.cryptoId);

  @override
  List<Object?> get props => [cryptoId];
}