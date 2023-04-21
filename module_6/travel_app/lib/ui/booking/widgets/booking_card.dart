import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String imageUrl;
  final String packageTitle;
  final String date;
  final String totalPrice;
  final String numPax;
  const BookingCard(
      {Key? key,
      this.onTap,
      required this.totalPrice,
      required this.numPax,
      required this.packageTitle,
      required this.imageUrl,
      required this.date})
      : super(key: key);

  // final imgUrl =
  //     'https://upload.wikimedia.org/wikipedia/commons/4/4b/La_Tour_Eiffel_vue_de_la_Tour_Saint-Jacques%2C_Paris_ao%C3%BBt_2014_%282%29.jpg';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: onTap,
            leading: Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            isThreeLine: true,
            title: Text(packageTitle),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date),
                Text('$numPax adults'),
              ],
            ),
            trailing: Text(
              'RM $totalPrice',
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
