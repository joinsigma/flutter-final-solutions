import 'package:flutter/material.dart';
import 'package:my_whatsapp/commons/styles.dart';
import 'package:my_whatsapp/commons/data.dart';
import 'package:my_whatsapp/screens/status/widgets/my_status_listtile.dart';
import 'package:my_whatsapp/screens/status/widgets/people_status_listview.dart';
import 'package:my_whatsapp/screens/status/widgets/status_search_bar.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 18.0,
                ),
                child: Text(
                  'Privacy',
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              // Page title
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 18.0,
                ),
                child: Text(
                  'Status',
                  style: kPageTitleStyle,
                ),
              ),

              // Search bar
              StatusSearchBar(),

              SizedBox(
                height: 20.0,
              ),

              // My status
              MyStatusListTile(),

              SizedBox(
                height: 20.0,
              ),

              // Listview header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                child: Text('VIEWED UPDATES'),
              ),

              // ListView - people status ListTile
              PeopleStatusListView(),
            ],
          ),
        ),
      ),
    );
  }
}
