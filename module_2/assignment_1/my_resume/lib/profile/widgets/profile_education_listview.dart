import 'package:flutter/material.dart';
import 'package:my_resume/commons/data.dart';
import 'package:my_resume/commons/styles.dart';

class ProfileEducationListView extends StatelessWidget {
  const ProfileEducationListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Education header
          const Text(
            'Education',
            style: kSectionHeaderTextStyle,
          ),

          const SizedBox(
            height: 20.0,
          ),

          // Education items
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(
              height: 20.0,
            ),
            itemCount: educationData.length,
            itemBuilder: (context, index) {
              return SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // School name & timeline
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          educationData[index]['schoolName'],
                          style: kSectionItemTitleTextStyle,
                        ),
                        Text(
                          educationData[index]['timeline'],
                          style: kSectionItemTitleTextStyle,
                        ),
                      ],
                    ),
                    // Programme
                    Text(
                      '${educationData[index]['programme']} with ${educationData[index]['achievement']}',
                      style: kSectionItemSubtitleTextStyle,
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
