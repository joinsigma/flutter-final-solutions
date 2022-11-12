import 'package:flutter/material.dart';
import 'package:my_whatsapp/commons/data.dart';

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
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: edit_profile_data['phone_num'],
                hintStyle: const TextStyle(color: Colors.black),
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
