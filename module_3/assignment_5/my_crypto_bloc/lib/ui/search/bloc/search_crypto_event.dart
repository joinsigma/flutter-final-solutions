import 'package:equatable/equatable.dart';

/// Todo 8: Prepare bloc events for Search crypto feature
/// 
/// - create an abstract class [ SearchCryptoEvent ] extends [ Equatable ]
/// - Event: [ SearchCryptoByKeyword ]

abstract class SearchCryptoEvent extends Equatable {}

class SearchCryptoByKeyword extends SearchCryptoEvent {
  final String keyword;
  
  SearchCryptoByKeyword(this.keyword);
  
  @override
  List<Object?> get props => [keyword];
}