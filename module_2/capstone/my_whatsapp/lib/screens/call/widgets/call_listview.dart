import 'package:flutter/material.dart';
import 'package:my_whatsapp/commons/data.dart';

class CallListView extends StatelessWidget {
  const CallListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: call_screen_data.length,

        // Build divider between each tile
        separatorBuilder: (context, index) => Divider(
          height: 1.0,
          color: Colors.grey[400],
        ),

        // Build ListTile for each call history
        itemBuilder: (context, index) {
          var isMissedCall = call_screen_data[index]['isMissed'];

          return ListTile(
            visualDensity: VisualDensity.compact,
            leading: CircleAvatar(
              radius: 19.0,
              backgroundImage:
                  NetworkImage(call_screen_data[index]['avatarUrl']),
            ),
            title: SizedBox(
              height: 25,
              child: Text(
                call_screen_data[index]['username'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isMissedCall ? Colors.redAccent : Colors.black,
                ),
              ),
            ),
            subtitle: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.phone,
                    size: 16.0,
                    color: Colors.grey,
                  ),
                ),
                isMissedCall
                    ? const Text('Missed')
                    : Text(call_screen_data[index]['callType']),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  call_screen_data[index]['callDate'],
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                const Icon(
                  Icons.info_outline,
                  size: 18.0,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
