import 'package:flutter/material.dart';
import 'package:my_crypto/data/model/crypto/crypto_details.dart';

class CryptoDetailsCard extends StatelessWidget {
  const CryptoDetailsCard({
    Key? key,
    required this.crypto,
  }) : super(key: key);

  final CryptoDetails crypto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 18.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Crypto name, icon, symbol
            ListTile(
              contentPadding: const EdgeInsets.all(0.0),
              leading: Image.network(crypto.iconUrl),
              title: Text(crypto.name),
              subtitle: Text(crypto.id),
            ),

            const Divider(color: Colors.black54),

            // Header: Todays Market
            const Text(
              'Todays Market',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),

            const SizedBox(height: 10.0),

            // Current Market Price
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current',
                    style: TextStyle(fontSize: 12.0, color: Colors.black54),
                  ),
                  Text(
                    'RM ${crypto.currentPriceMyr.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),

            // 24-h high
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '24-h High',
                    style: TextStyle(fontSize: 12.0, color: Colors.black54),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'RM ${crypto.highIn24Hour.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const Icon(
                        Icons.arrow_circle_up,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 24-h low
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '24-h Low',
                    style: TextStyle(fontSize: 12.0, color: Colors.black54),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'RM ${crypto.lowIn24Hour.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const Icon(
                        Icons.arrow_circle_down,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.black54),

            // Header: History
            const Text(
              'History',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),

            const SizedBox(height: 10.0),

            // All time high
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'All Time High',
                    style: TextStyle(fontSize: 12.0, color: Colors.black54),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'RM ${crypto.allTimeHighMyr.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const Icon(
                        Icons.trending_up,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // All time low
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'All Time Low',
                    style: TextStyle(fontSize: 12.0, color: Colors.black54),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'RM ${crypto.allTimeLowMyr.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const Icon(
                        Icons.trending_down,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
