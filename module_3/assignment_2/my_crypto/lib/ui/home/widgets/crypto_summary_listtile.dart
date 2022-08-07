import 'package:flutter/material.dart';
import 'package:my_crypto/data/model/crypto/crypto_summary.dart';
import 'package:my_crypto/ui/details/crypto_details_screen.dart';

class CryptoSummaryListTile extends StatelessWidget {
  const CryptoSummaryListTile({
    Key? key,
    required this.crypto,
  }) : super(key: key);

  final CryptoSummary crypto;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CryptoDetailsScreen(
              cryptoId: crypto.id,
            ),
          ),
        );
      },
      title: Text(crypto.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(crypto.id),
              Text(crypto.symbol),
            ],
          ),
          const Divider(
            color: Colors.black26,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price: ',
                // style: TextStyle(color: Colors.grey),
              ),
              Text(
                'RM ${crypto.currentPriceMyr!.toStringAsFixed(2)}',
              ),
            ],
          )
        ],
      ),
      leading: CircleAvatar(
        radius: 21,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            crypto.logoUrl,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
