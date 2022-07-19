import 'package:flutter/material.dart';
import 'package:my_whatsapp/commons/styles.dart';

class CallPageTitle extends StatelessWidget {
  const CallPageTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Text(
        'Calls',
        style: kPageTitleStyle,
      ),
    );
  }
}
