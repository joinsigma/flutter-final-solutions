import 'package:flutter/material.dart';
import 'package:my_resume/commons/data.dart';
import 'package:my_resume/commons/styles.dart';

class ProfileWorkingExpListView extends StatelessWidget {
  const ProfileWorkingExpListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Working Experience header
          const Text(
            'Working Experience',
            style: kSectionHeaderTextStyle,
          ),

          const SizedBox(
            height: 20.0,
          ),

          // Working experience listview
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(
              height: 20.0,
            ),
            itemCount: workingExp.length,
            itemBuilder: (context, index) {
              return SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Org name and timeline
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          workingExp[index]['orgName'],
                          style: kSectionItemTitleTextStyle,
                        ),
                        Text(
                          workingExp[index]['timeline'],
                          style: kSectionItemTitleTextStyle,
                        ),
                      ],
                    ),

                    // Position
                    Text(
                      workingExp[index]['position'],
                      style: const TextStyle(fontSize: 13.0),
                    ),

                    // Description
                    Text(
                      workingExp[index]['description'],
                      style: kSectionItemSubtitleTextStyle,
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
