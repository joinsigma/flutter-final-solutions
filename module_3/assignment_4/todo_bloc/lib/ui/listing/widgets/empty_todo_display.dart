import 'package:flutter/material.dart';

class EmptyTodoDisplay extends StatelessWidget {
  const EmptyTodoDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'You have no Todos at the moment. \nStart planning now.',
            style: TextStyle(color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
