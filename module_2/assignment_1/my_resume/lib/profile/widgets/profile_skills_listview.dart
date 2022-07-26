import 'package:flutter/material.dart';
import 'package:my_resume/commons/data.dart';
import 'package:my_resume/commons/styles.dart';

class ProfileSkillsListView extends StatelessWidget {
  const ProfileSkillsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Skills header
          const Text(
            'Skills',
            style: kSectionHeaderTextStyle,
          ),

          const SizedBox(
            height: 20.0,
          ),

          // Skills listview
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(
              height: 20.0,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skills[index]['type'],
                      style: kSectionItemTitleTextStyle,
                    ),
                    Text(
                      skills[index]['content'],
                      style: kSectionItemSubtitleTextStyle,
                    ),
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
