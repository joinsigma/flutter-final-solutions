import 'package:flutter/material.dart';
import 'package:my_whatsapp/screens/settings/widgets/edit_about_column.dart';
import 'package:my_whatsapp/screens/settings/widgets/edit_phone_num_column.dart';
import 'package:my_whatsapp/screens/settings/widgets/edit_profile_tile.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.chevron_left,
              color: Colors.blue[600],
              size: 26.0,
            ),
          ),
          centerTitle: true,
          toolbarHeight: 50,
          backgroundColor: Colors.grey[300],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // Edit Profile Upper part
              EditProfileTile(),

              SizedBox(height: 20),

              // Middle - Phone Number
              EditPhoneNumberColumn(),

              SizedBox(height: 20),

              // Bottom - About
              EditAboutColumn()
            ],
          ),
        ),
      ),
    );
  }
}
