import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_crypto_bloc/data/model/crypto/crypto_summary.dart';
import 'package:my_crypto_bloc/ui/details/crypto_details_screen.dart';
import 'package:my_crypto_bloc/ui/home/bloc/home_page_bloc.dart';
import 'package:my_crypto_bloc/ui/home/bloc/home_page_state.dart';

/// Todo 16: Implement Homepage Bloc for screen transition to Crypto Details Screen
/// - Tapping on the List tile should navigate the user to crypto details screen
/// - trigger corrresponding event to the bloc
class CryptoSummaryListTile extends StatefulWidget {
  const CryptoSummaryListTile({
    Key? key,
    required this.crypto,
  }) : super(key: key);

  final CryptoSummary crypto;

  @override
  State<CryptoSummaryListTile> createState() => _CryptoSummaryListTileState();
}

class _CryptoSummaryListTileState extends State<CryptoSummaryListTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CryptoDetailsScreen(
                  cryptoId: widget.crypto.id,
                ),
              ),
            );
          },
          title: Text(widget.crypto.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.crypto.id),
                  Text(widget.crypto.symbol),
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
                    'RM ${widget.crypto.currentPriceMyr!.toStringAsFixed(2)}',
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
                widget.crypto.logoUrl,
              ),
              backgroundColor: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
