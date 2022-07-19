import 'package:flutter/material.dart';

class ChatTextButtonRow extends StatelessWidget {
  const ChatTextButtonRow({
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
            'Broadcast Lists',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'New Group',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
