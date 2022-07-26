import 'package:flutter/material.dart';
import 'package:my_resume/commons/data.dart';
import 'package:my_resume/commons/styles.dart';

class ProfileContacts extends StatelessWidget {
  const ProfileContacts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          const Text(
            'Contacts',
            style: kSectionHeaderTextStyle,
          ),

          const SizedBox(
            height: 20.0,
          ),

          // Email
          Row(
            children: [
              const Expanded(
                child: Text('Email:'),
              ),
              Expanded(
                child: Text(
                  profileData['email'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              )
            ],
          ),

          // Phone no
          Row(
            children: [
              const Expanded(
                child: Text('Phone no:'),
              ),
              Expanded(
                child: Text(
                  profileData['phoneNumber'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),

          // Address
          Row(
            children: [
              const Expanded(
                child: Text('Address:'),
              ),
              Expanded(
                child: Text(
                  profileData['address'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
