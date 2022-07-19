import 'package:flutter/material.dart';
import 'package:my_whatsapp/screens/call/widgets/call_header_bar.dart';
import 'package:my_whatsapp/screens/call/widgets/call_listview.dart';
import 'package:my_whatsapp/screens/call/widgets/call_page_title.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
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
              // Page header button & tabs
              CallHeaderBar(),

              // Page title
              CallPageTitle(),

              // ListView of calls
              CallListView(),
            ],
          ),
        ),
      ),
    );
  }
}
