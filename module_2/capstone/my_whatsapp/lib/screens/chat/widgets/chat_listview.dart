import 'package:flutter/material.dart';
import 'package:my_whatsapp/commons/data.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: chat_screen_data.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            visualDensity: VisualDensity.compact,
            leading: CircleAvatar(
              radius: 19.0,
              backgroundImage:
                  NetworkImage(chat_screen_data[index]['avatarUrl']),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(chat_screen_data[index]['username'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                ),
                Text(
                  chat_screen_data[index]['messageTime'],
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
            subtitle: SizedBox(
              height: 35,
              child: Text(
                chat_screen_data[index]['latestMessage'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }
}
