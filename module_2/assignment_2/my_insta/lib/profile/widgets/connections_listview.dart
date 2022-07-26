import 'package:flutter/material.dart';
import 'package:my_insta/commons/data.dart';

///Horizontal listview composed of avatar and uid
class ConnectionsListView extends StatelessWidget {
  const ConnectionsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: profileData['connections'].length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 5.0,
              right: 5.0,
              bottom: 6.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                // Connections Avatar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black54),
                  ),
                  width: 50.0,
                  height: 50.0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 22.0,
                      backgroundImage: NetworkImage(
                        profileData['connections'][index]['avatarUrl'],
                      ),
                    ),
                  ),
                ),

                // Connections Label
                SizedBox(
                  width: 60,
                  child: Text(
                    profileData['connections'][index]['uid'],
                    style: const TextStyle(fontSize: 12.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
