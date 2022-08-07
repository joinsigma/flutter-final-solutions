import 'package:bloc/bloc.dart';
import 'package:my_crypto_bloc/data/network/exceptions.dart';
import 'package:my_crypto_bloc/data/repository/crypto_repository.dart';
import 'package:my_crypto_bloc/ui/details/bloc/crypto_details_event.dart';
import 'package:my_crypto_bloc/ui/details/bloc/crypto_details_state.dart';

/// Todo 13: Create the bloc for crypto details
/// - Create a [ CryptoDetailsBloc ]
/// - Set the initial state to [ CryptoDetailsLoading ]
/// - Create a handler methods for each search event: [ GetCryptoDetailsById ]
/// - Map the handler method to the event

class CryptoDetailsBloc extends Bloc<CryptoDetailsEvent, CryptoDetailsState> {
  final CryptoRepository _cryptoRepository;

  // Constructor
  CryptoDetailsBloc(this._cryptoRepository) : super(CryptoDetailsLoading()) {
    on<GetCryptoDetailsById>(_onGetCryptoDetailsById);
  }

  /// Handler methods for event: [ GetCryptoDetailsById ]
  void _onGetCryptoDetailsById(
    GetCryptoDetailsById event,
    Emitter<CryptoDetailsState> emit,
  ) async {
    try {
      emit(
        CryptoDetailsLoading(),
      );
      final cryptoDetails =
          await _cryptoRepository.getCryptoDetailsById(event.cryptoId);
      emit(
        CryptoDetailsLoaded(cryptoDetails),
      );
    } on GetCryptoDetailsException catch (exception) {
      emit(
        CryptoDetailsFailed(exception.errorMsg),
      );
    }
  }
}
