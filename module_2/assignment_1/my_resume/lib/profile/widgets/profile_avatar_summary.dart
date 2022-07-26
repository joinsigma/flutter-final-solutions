import 'package:flutter/material.dart';
import 'package:my_resume/commons/data.dart';

class ProfileAvatarSummary extends StatelessWidget {
  const ProfileAvatarSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        CircleAvatar(
          radius: 32.0,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 31.0,
            backgroundImage: NetworkImage(profileData['avatarUrl']),
          ),
        ),

        const SizedBox(
          width: 16.0,
        ),

        // Name and Description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileData['name'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5.0),
              Text(
                profileData['description'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
