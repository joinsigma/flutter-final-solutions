import 'package:flutter/material.dart';
import 'package:my_whatsapp/commons/styles.dart';
import 'package:my_whatsapp/screens/chat/widgets/chat_header_bar.dart';
import 'package:my_whatsapp/screens/chat/widgets/chat_listview.dart';
import 'package:my_whatsapp/screens/chat/widgets/chat_search_bar.dart';
import 'package:my_whatsapp/screens/chat/widgets/chat_textbutton_row.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // Header bar
              ChatHeaderBar(),

              // Page Title
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                child: Text(
                  'Chats',
                  style: kPageTitleStyle,
                ),
              ),

              // Search Bar
              ChatSearchBar(),

              SizedBox(height: 20.0),

              // Text Button Row
              ChatTextButtonRow(),

              Divider(),

              // ListView of Chats
              ChatListView(),
            ],
          ),
        ),
      ),
    );
  }
}
