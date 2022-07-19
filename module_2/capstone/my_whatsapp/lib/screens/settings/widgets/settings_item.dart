import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    Key? key,
    required this.leadingIconColor,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final Color leadingIconColor;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      leading: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: leadingIconColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.0,
        color: Colors.grey[400],
      ),
      tileColor: Colors.white,
      visualDensity: const VisualDensity(
        vertical: VisualDensity.minimumDensity,
        horizontal: VisualDensity.minimumDensity,
      ),
      shape: Border(
        top: BorderSide(color: Colors.grey[300]!, width: 0.5),
        bottom: BorderSide(color: Colors.grey[300]!, width: 0.5),
      ),
    );
  }
}
