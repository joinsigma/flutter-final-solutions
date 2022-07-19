import 'package:flutter/material.dart';

class ChatHeaderBar extends StatelessWidget {
  const ChatHeaderBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Edit',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.edit_note,
            color: Colors.blue,
            size: 20.0,
          ),
        )
      ],
    );
  }
}
