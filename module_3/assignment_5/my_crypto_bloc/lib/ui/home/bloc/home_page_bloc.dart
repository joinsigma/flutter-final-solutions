import 'package:bloc/bloc.dart';
import 'package:my_crypto_bloc/data/network/exceptions.dart';
import 'package:my_crypto_bloc/data/repository/crypto_repository.dart';
import 'package:my_crypto_bloc/ui/home/bloc/home_page_event.dart';
import 'package:my_crypto_bloc/ui/home/bloc/home_page_state.dart';

/// Todo 7: Create the bloc for homepage
/// - Create a [ HomepageBloc ]
/// - Set the initial state to [ HomepageCryptoLoading ]
/// - Create a handler methods for each homepage event: [ GetHomepageCrypto ]
/// - Map the handler method to the event

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final CryptoRepository _cryptoRepository;

  HomepageBloc(this._cryptoRepository) : super(HomepageCryptoLoading()) {
    on<GetHomepageCrypto>(_onLoadHomepageCrypto);
  }

  // Methods that handle event: LoadHomepageCrypto
  void _onLoadHomepageCrypto(
    GetHomepageCrypto event,
    Emitter<HomepageState> emit,
  ) async {
    try {
      emit(
        HomepageCryptoLoading(),
      );

      final cryptos = await _cryptoRepository.getHomePageCrypto();

      emit(
        HomepageCryptoLoaded(cryptos),
      );
    } on GetHomepageCryptoException catch (exception) {
      emit(
        HomepageCryptoFailed(exception.errorMsg),
      );
    }
  }
}
