import 'package:flutter/material.dart';
import 'package:my_crypto/data/model/crypto/crypto_details.dart';
import 'package:my_crypto/data/repository/crypto_repository.dart';
import 'package:my_crypto/ui/details/widgets/crypto_details_card.dart';

class CryptoDetailsScreen extends StatelessWidget {
  final String cryptoId;

  const CryptoDetailsScreen({
    super.key,
    required this.cryptoId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: FutureBuilder(
              future: CryptoRepository.empty().getCryptoDetailsById(cryptoId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error Loading Crypto Details with cryptoId: $cryptoId',
                      ),
                    );
                  }

                  CryptoDetails crypto = snapshot.data!;
                  return CryptoDetailsCard(crypto: crypto);
                }

                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
