import 'package:flutter/material.dart';

class ApiErrorDisplay extends StatelessWidget {
  const ApiErrorDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Error communicating with server. Please try again later',
            style: TextStyle(color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
