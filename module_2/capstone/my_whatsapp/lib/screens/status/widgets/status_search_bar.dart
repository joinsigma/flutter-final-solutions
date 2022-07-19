import 'package:flutter/material.dart';

class StatusSearchBar extends StatelessWidget {
  const StatusSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
        ),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search',
            isDense: true,
            filled: true,
            fillColor: Colors.grey[400],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
