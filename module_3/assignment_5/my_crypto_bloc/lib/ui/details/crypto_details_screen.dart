import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_crypto_bloc/data/model/crypto/crypto_details.dart';
import 'package:my_crypto_bloc/ui/details/bloc/crypto_details_bloc.dart';
import 'package:my_crypto_bloc/ui/details/bloc/crypto_details_event.dart';
import 'package:my_crypto_bloc/ui/details/bloc/crypto_details_state.dart';
import 'package:my_crypto_bloc/ui/details/widgets/crypto_details_card.dart';

/// Todo 17: Implement crypto details bloc
class CryptoDetailsScreen extends StatefulWidget {
  final String cryptoId;

  const CryptoDetailsScreen({
    super.key,
    required this.cryptoId,
  });

  @override
  State<CryptoDetailsScreen> createState() => _CryptoDetailsScreenState();
}

class _CryptoDetailsScreenState extends State<CryptoDetailsScreen> {
  late CryptoDetailsBloc _cryptoDetailsBloc;

  @override
  void initState() {
    _cryptoDetailsBloc = kiwi.KiwiContainer().resolve<CryptoDetailsBloc>();
    _cryptoDetailsBloc.add(GetCryptoDetailsById(widget.cryptoId));
    super.initState();
  }

  @override
  void dispose() {
    _cryptoDetailsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CryptoDetailsBloc>(
      create: (context) => _cryptoDetailsBloc,
      child: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: const Text('Crypto Details'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Card(
              child: BlocBuilder<CryptoDetailsBloc, CryptoDetailsState>(
                builder: (context, state) {
                  if (state is CryptoDetailsLoading) {
                    return buildLoading();
                  } else if (state is CryptoDetailsFailed) {
                    return buildError(state);
                  } else if (state is CryptoDetailsLoaded) {
                    CryptoDetails cryptoDetails = state.cryptoDetails;
                    return CryptoDetailsCard(crypto: cryptoDetails);
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center buildError(CryptoDetailsFailed state) {
    return Center(
      child: Text(state.errorMsg),
    );
  }

  Center buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
