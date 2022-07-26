import 'package:flutter/material.dart';
import 'package:my_insta/commons/data.dart';

/// Gridview that will display user posts images.
///
/// Since we have 3 tabs, we need to provide 3 gridview items
class ImagesGridView extends StatelessWidget {
  const ImagesGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: TabBarView(
        children: [
          // Images of first tab
          GridView.count(
            primary: false,
            crossAxisCount: 3,
            children: List.generate(
              profileData['postsImage'].length,
              (index) => SizedBox(
                child: Image.network(
                  profileData['postsImage'][index],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),

          // Images of second tab
          GridView.count(
            primary: false,
            crossAxisCount: 3,
            children: List.generate(
              profileData['postsImage'].length,
              (index) => SizedBox(
                child: Image.network(
                  profileData['postsImage'][index],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),

          // Images of third tab
          GridView.count(
            crossAxisCount: 3,
            children: List.generate(
              profileData['postsImage'].length,
              (index) => SizedBox(
                child: Image.network(
                  profileData['postsImage'][index],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            primary: false,
            shrinkWrap: true,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}
