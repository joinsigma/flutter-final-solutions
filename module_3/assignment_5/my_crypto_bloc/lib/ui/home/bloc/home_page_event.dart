import 'package:equatable/equatable.dart';

/// Todo 5: Prepare bloc events for Homepage
///
/// - create an abstract class [ HomepageEvent ] extends [ Equatable ]
/// - Event: [ GetHomepageCrypto ]

abstract class HomepageEvent extends Equatable {}

class GetHomepageCrypto extends HomepageEvent {
  @override
  List<Object?> get props => [];
}

class HomepageToCryptoDetailsScreen extends HomepageEvent {
  final String cryptoId;

  HomepageToCryptoDetailsScreen(this.cryptoId);

  @override
  List<Object?> get props => [];
}
