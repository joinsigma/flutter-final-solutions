import 'package:bloc/bloc.dart';
import 'package:my_crypto_bloc/data/network/exceptions.dart';
import 'package:my_crypto_bloc/data/repository/crypto_repository.dart';
import 'package:my_crypto_bloc/ui/search/bloc/search_crypto_event.dart';
import 'package:my_crypto_bloc/ui/search/bloc/search_crypto_state.dart';

/// Todo 10: Create the bloc for search crypto feature
/// - Create a [ SearchCryptoBloc ]
/// - Set the initial state to [ SearchResultsLoading ]
/// - Create a handler methods for each search event: [ SearchCryptoByKeyword ]
/// - Map the handler method to the event

class SearchCryptoBloc extends Bloc<SearchCryptoEvent, SearchCryptoState> {
  final CryptoRepository _cryptoRepository;

  // Constructor
  SearchCryptoBloc(this._cryptoRepository) : super(SearchResultsLoading()) {
    on<SearchCryptoByKeyword>(_onSearchCryptoByKeyword);
  }

  /// Handler methods for event: [ SearchCryptoByKeyword ]
  void _onSearchCryptoByKeyword(
    SearchCryptoByKeyword event,
    Emitter<SearchCryptoState> emit,
  ) async {
    try {
      emit(
        SearchResultsLoading(),
      );
      final searchResults =
          await _cryptoRepository.searchCryptoByKeyword(event.keyword);
      emit(
        SearchResultsLoaded(searchResults),
      );
    } on SearchCryptoException catch (exception) {
      emit(
        SearchResultsFailed(exception.errorMsg),
      );
    }
  }
}
