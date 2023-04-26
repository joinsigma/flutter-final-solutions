import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/detail/detail_screen.dart';
import 'package:travel_app/ui/likes/likes_bloc.dart';

import '../../../data/model/package.dart';

class LikeCard extends StatelessWidget {
  final Package package;
  const LikeCard({Key? key, required this.package}) : super(key: key);

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
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(id: package.id, title: package.title),
                  ),
                );
              },
              child: Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Image.network(
                  package.imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            isThreeLine: true,
            title: Text(package.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(package.location),
                Text(
                  'RM${package.price}/person',
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                BlocProvider.of<LikesBloc>(context)
                    .add(TriggerUnlike(packageId: package.id));
              },
              child: const Icon(
                Icons.delete,
                size: 25.0,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
