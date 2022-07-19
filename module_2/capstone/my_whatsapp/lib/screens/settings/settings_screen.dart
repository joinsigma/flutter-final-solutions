import 'package:flutter/material.dart';
import 'package:my_whatsapp/commons/styles.dart';
import 'package:my_whatsapp/screens/settings/widgets/settings_listview.dart';
import 'package:my_whatsapp/screens/settings/widgets/settings_profile_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 20.0,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
              child: Text(
                'Settings',
                style: kPageTitleStyle,
              ),
            ),

            // Profile ListTile
            const SettingsProfileTile(),

            const SizedBox(
              height: 20.0,
            ),

            const SettingsListView(),
          ],
        ),
      ),
    );
  }
}
