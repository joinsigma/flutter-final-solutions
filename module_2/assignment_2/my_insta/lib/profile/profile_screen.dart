import 'package:flutter/material.dart';
import 'package:my_insta/commons/data.dart';
import 'package:my_insta/profile/widgets/connections_listview.dart';
import 'package:my_insta/profile/widgets/contacts_buttonbar.dart';
import 'package:my_insta/profile/widgets/images_gridview.dart';
import 'package:my_insta/profile/widgets/profile_avatar.dart';
import 'package:my_insta/profile/widgets/profile_bio.dart';
import 'package:my_insta/profile/widgets/profile_summary.dart';
import 'package:my_insta/profile/widgets/profile_tabbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: const [Icon(Icons.more_vert)],
            leading: const Icon(Icons.chevron_left),
            title: Text(
              profileData['uid'],
              style: const TextStyle(fontSize: 16.0),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            toolbarHeight: 35.0,
            elevation: 0.5,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Biography section
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar and status
                      Row(
                        children: [
                          // Avatar
                          const ProfileAvatar(),

                          const SizedBox(width: 15.0),

                          // Summary of post, followers and following
                          ProfileSummary(
                            categoryNumber: profileData['postsNum'].toString(),
                            categoryLabel: 'Posts',
                          ),
                          ProfileSummary(
                            categoryNumber:
                                profileData['followersNum'].toString(),
                            categoryLabel: 'Followers',
                          ),
                          ProfileSummary(
                            categoryNumber:
                                profileData['followingNum'].toString(),
                            categoryLabel: 'Following',
                          ),
                        ],
                      ),

                      // Biography - name, occupation, about
                      const ProfileBio(),
                      
                      const SizedBox(height: 10.0),

                      // Button bar
                      const ContactsButtonBar(),

                      const SizedBox(height: 10.0),

                      // Horizontal Listview
                      const ConnectionsListView(),
                    ],
                  ),
                ),

                const Divider(
                  color: Colors.black38,
                ),

                // TabView of images
                const ProfileTabBar(),

                // TabBarView
                const ImagesGridView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
