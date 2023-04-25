import 'package:flutter/material.dart';

class TravelPackageCard extends StatelessWidget {
  final String title;
  final bool isFavourite;
  final String location;
  final int price;
  final String imgUrl;
  final List<String> tags;
  const TravelPackageCard(
      {Key? key,
      required this.title,
      required this.isFavourite,
      required this.tags,
      required this.imgUrl,
      required this.price,
      required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 4.0,
          color: Color(0xFFF5F5F5),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(imgUrl, width: double.infinity, height: 250),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            title,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          location,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'RM$price/person',
                          style: const TextStyle(
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        )
                      ],
                    ),

                    ///Favourite icon.
                    //  const Spacer(),
                    // isFavourite ? const Icon(
                    //    Icons.favorite,
                    //    color: Colors.redAccent,
                    //    size: 30.0,
                    //  ): const Icon(
                    //   Icons.favorite_outline,
                    //   color: Colors.redAccent,
                    //   size: 30.0,
                    // )
                  ],
                ),
                Wrap(
                  spacing: 5.0,
                  children: _buildTags(tags),
                )
                // Wrap(
                //   spacing: 5.0,
                //   children: const [
                //     Chip(
                //       backgroundColor: Colors.orange,
                //       label: Text(
                //         'Eagle Feeding',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //     Chip(
                //       label: Text('Cable car'),
                //     ),
                //     Chip(
                //       label: Text('Island hopping'),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Chip> _buildTags(List<String> tags) {
    List<Chip> chips = [];
    for (var t in tags) {
      chips.add(
        Chip(
          backgroundColor: Colors.orange,
          label: Text(
            t,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return chips;
  }
}
