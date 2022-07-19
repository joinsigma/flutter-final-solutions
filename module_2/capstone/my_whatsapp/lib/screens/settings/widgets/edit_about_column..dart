import 'package:flutter/material.dart';

class EditAboutColumn extends StatelessWidget {
  const EditAboutColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            'ABOUT',
            style: TextStyle(color: Colors.grey[700], fontSize: 12.0),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Hello World',
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
