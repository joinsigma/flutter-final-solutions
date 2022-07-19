import 'package:flutter/material.dart';
import 'package:my_whatsapp/screens/settings/edit_profile_screen.dart';

class SettingsProfileTile extends StatelessWidget {
  const SettingsProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditProfileScreen(),
          ),
        );
      },
      child: ListTile(
        leading: const CircleAvatar(
          radius: 20.0,
          backgroundImage:
              NetworkImage('https://picsum.photos/id/1025/100/100'),
        ),
        title: const SizedBox(
          height: 20.0,
          child: Text(
            'Calibre Cliff',
            style: TextStyle(fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: const Text(
          'Hello World',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: const Center(
            child: Icon(
              Icons.qr_code,
              size: 18.0,
              color: Colors.blue,
            ),
          ),
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
