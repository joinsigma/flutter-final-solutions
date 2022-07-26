import 'package:flutter/material.dart';
import 'package:my_resume/profile/widgets/profile_avatar_summary.dart';
import 'package:my_resume/profile/widgets/profile_contacts.dart';
import 'package:my_resume/profile/widgets/profile_education_listview.dart';
import 'package:my_resume/profile/widgets/profile_skills_listview.dart';
import 'package:my_resume/profile/widgets/profile_working_exp_listview.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                // Avatar & summary
                ProfileAvatarSummary(),
                SizedBox(height: 10.0),
                Divider(color: Colors.black54),

                // Contacts
                ProfileContacts(),
                Divider(color: Colors.black54),

                // Education
                ProfileEducationListView(),
                Divider(color: Colors.black54),

                // Skills
                ProfileSkillsListView(),
                Divider(color: Colors.black54),

                // Working Experience
                ProfileWorkingExpListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
