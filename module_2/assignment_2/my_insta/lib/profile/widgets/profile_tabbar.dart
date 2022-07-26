import 'package:flutter/material.dart';


/// Tab bar of the user images.
class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      indicatorColor: Colors.black45,
      labelColor: Colors.black,
      tabs: [
        SizedBox(
          height: 30.0,
          child: Tab(
            icon: Icon(Icons.apps),
          ),
        ),
        SizedBox(
          height: 30.0,
          child: Tab(
            icon: Icon(Icons.tv),
          ),
        ),
        SizedBox(
          height: 30.0,
          child: Tab(
            icon: Icon(Icons.assignment_ind_outlined),
          ),
        ),
      ],
    );
  }
}
