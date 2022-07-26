import 'package:flutter/material.dart';
import 'package:my_insta/commons/data.dart';


/// Avatar of the user, wrapped inside insta-border
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        // Colorful border
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.purple,
                Colors.pink,
                Colors.deepOrange,
                Colors.yellow,
              ],
            ),
          ),
        ),

        // white ring around image
        Container(
          width: 76.0,
          height: 76.0,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),

        // avatar image
        CircleAvatar(
          radius: 36.0,
          backgroundImage: NetworkImage(profileData['avatarUrl']),
        ),
      ],
    );
  }
}
