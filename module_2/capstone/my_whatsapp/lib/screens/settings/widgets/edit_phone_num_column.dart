import 'package:flutter/material.dart';

class EditPhoneNumberColumn extends StatelessWidget {
  const EditPhoneNumberColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            'PHONE NUMBER',
            style: TextStyle(color: Colors.grey[700], fontSize: 12.0),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '+6011-8434-3213',
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
