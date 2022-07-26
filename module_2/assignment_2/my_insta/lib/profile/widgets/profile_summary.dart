import 'package:flutter/material.dart';

/// Widget that display numbers and label in top-down structure.
/// 
/// Used in displaying number of posts, followers, following.
class ProfileSummary extends StatelessWidget {
  final String categoryNumber;
  final String categoryLabel;

  const ProfileSummary({
    Key? key,
    required this.categoryNumber,
    required this.categoryLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Text(
                categoryNumber,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              categoryLabel,
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
