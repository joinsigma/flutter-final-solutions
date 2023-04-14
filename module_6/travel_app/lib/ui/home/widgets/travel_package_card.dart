import 'package:flutter/material.dart';
class TravelPackageCard extends StatelessWidget {
  final VoidCallback onTap;
  const TravelPackageCard({Key? key,required this.onTap}) : super(key: key);
  final imgUrl =
      'https://upload.wikimedia.org/wikipedia/commons/4/4b/La_Tour_Eiffel_vue_de_la_Tour_Saint-Jacques%2C_Paris_ao%C3%BBt_2014_%282%29.jpg';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 4.0,
          color: Color(0xFFF5F5F5),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(imgUrl,
                    width: double.infinity, height: 250),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:
                          MediaQuery.of(context).size.width * 0.7,
                          child: const Text(
                            '3D2N Langkawi Tour, 3D2N Langkawi Tour, 3D2N Langkawi Tour',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Langkawi, Malaysia',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'RM300/person',
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        )
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                      size: 30.0,
                    )
                  ],
                ),
                Wrap(
                  spacing: 5.0,
                  children: const [
                    Chip(
                        backgroundColor: Colors.orange,
                        label: Text(
                          'Eagle Feeding',
                          style: TextStyle(color: Colors.white),
                        )),
                    Chip(
                      label: Text('Cable car'),
                    ),
                    Chip(
                      label: Text('Island hopping'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
