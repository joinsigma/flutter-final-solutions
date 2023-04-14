import 'package:flutter/material.dart';
import 'package:travel_app/ui/profile/widgets/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileImg =
      "https://media.formula1.com/content/dam/fom-website/drivers/2023Drivers/verstappen.jpg.img.640.medium.jpg/1677069646195.jpg";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    ///Todo: Navigate to Edit profile
                  },
                  child: const Text('Edit'),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(profileImg),
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.orange, shape: BoxShape.circle),
                          child: GestureDetector(
                            onTap: () {
                              ///Todo: Trigger bottom sheet
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage:
                                            NetworkImage(profileImg),
                                      ),
                                      title: Text('Change profile picture ?'),
                                      actions: [
                                        Text('Yes'),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('No')
                                      ],
                                    );
                                  });
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ProfileCard(
                  title: 'Trips',
                  count: '12',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ProfileCard(
                  title: 'Likes',
                  count: '12',
                ),
              ),
            ],
          ),
          ListTile(
            title: Text('Name'),
            subtitle: Text('Shahidan'),
          ),
          Divider(),
          ListTile(
            title: Text('Email'),
            subtitle: Text('shah05@gmail.com'),
          ),
          Divider(),
          ListTile(
            title: Text('Address'),
            subtitle: Text('12 Avenue Cicero'),
          ),
        ],
      ),
    );
  }
}
