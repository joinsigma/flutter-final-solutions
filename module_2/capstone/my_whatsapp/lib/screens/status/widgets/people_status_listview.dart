import 'package:flutter/material.dart';
import 'package:my_whatsapp/commons/data.dart';

class PeopleStatusListView extends StatelessWidget {
  const PeopleStatusListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false, // disable listview scroll, will use SingleChildScrollView
      shrinkWrap: true, // limit height
      itemCount: status_screen_data.length,
      itemBuilder: (context, index) {
        return ListTile(
          visualDensity: VisualDensity.compact,
          title: Text(
            status_screen_data[index]['username'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(status_screen_data[index]['status']),
          leading: Container(
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 18.0,
                backgroundImage: NetworkImage(
                  status_screen_data[index]['avatarUrl'],
                ),
              ),
            ),
          ),
          tileColor: Colors.white,
          shape: Border(
            bottom: BorderSide(color: Colors.grey[300]!),
          ),
        );
      },
    );
  }
}
