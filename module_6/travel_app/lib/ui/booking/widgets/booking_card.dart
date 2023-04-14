import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final VoidCallback? onTap;
  const BookingCard({Key? key, this.onTap}) : super(key: key);

  final imgUrl =
      'https://upload.wikimedia.org/wikipedia/commons/4/4b/La_Tour_Eiffel_vue_de_la_Tour_Saint-Jacques%2C_Paris_ao%C3%BBt_2014_%282%29.jpg';

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
                imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            isThreeLine: true,
            title: const Text('3D2N Langkawi Tour'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('12th Mar 2023'),
                Text('ID: 122203334'),
              ],
            ),
            trailing: const Text(
              'RM3,000',
              style: TextStyle(
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
