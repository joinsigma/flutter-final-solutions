import 'package:flutter/material.dart';
import 'package:my_whatsapp/screens/settings/widgets/settings_item.dart';

class SettingsListView extends StatelessWidget {
  const SettingsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        primary: false,
        children: [
          // Starred Messages
          const SettingsItem(
            leadingIconColor: Colors.orange,
            icon: Icons.star,
            label: 'Starred Messages',
          ),

          // Linked Devices
          SettingsItem(
            leadingIconColor: Colors.green[900]!,
            icon: Icons.computer,
            label: 'Linked Devices',
          ),

          const SizedBox(
            height: 20.0,
          ),

          // Account
          const SettingsItem(
            leadingIconColor: Colors.blue,
            icon: Icons.key,
            label: 'Account',
          ),

          // Chats
          const SettingsItem(
            leadingIconColor: Colors.green,
            icon: Icons.whatsapp,
            label: 'Chats',
          ),

          // Notification
          const SettingsItem(
            leadingIconColor: Colors.red,
            icon: Icons.notifications,
            label: 'Notifications',
          ),

          // Storage and Data
          SettingsItem(
            leadingIconColor: Colors.green[600]!,
            icon: Icons.compare_arrows,
            label: 'Storage and Data',
          ),

          const SizedBox(
            height: 20.0,
          ),

          // Help
          SettingsItem(
            leadingIconColor: Colors.blue[700]!,
            icon: Icons.info_outline,
            label: 'Help',
          ),

          // Tell a friend
          SettingsItem(
            leadingIconColor: Colors.green[900]!,
            icon: Icons.face,
            label: 'Tell a Friend',
          ),
        ],
      ),
    );
  }
}
