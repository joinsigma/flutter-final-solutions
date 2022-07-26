import 'package:flutter/material.dart';
import 'package:my_insta/commons/data.dart';

/// Column containing user fullname, occupaction and short bio.
class ProfileBio extends StatelessWidget {
  const ProfileBio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 4.0,
          ),
          child: Text(
            profileData['fullname'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            profileData['occupation'],
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          profileData['bio'],
          style: const TextStyle(wordSpacing: 1.0),
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
