import 'package:flutter/material.dart';
import 'package:my_insta/commons/styles.dart';

class ContactsButtonBar extends StatelessWidget {
  const ContactsButtonBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Follow button
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text('Follow'),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ),
        const SizedBox(width: 8.0),

        // Message button
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text('Message'),
            style: kContactOutlinedButtonStyle,
          ),
        ),
        const SizedBox(width: 8.0),

        // Email button
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text('Email'),
            style: kContactOutlinedButtonStyle,
          ),
        ),
        const SizedBox(width: 8.0),

        // More button
        SizedBox(
          width: 24,
          child: OutlinedButton(
            onPressed: () {},
            child: const Icon(
              Icons.more_horiz_rounded,
              size: 14.0,
            ),
            style: kContactOutlinedButtonStyle.copyWith(
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(0.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
