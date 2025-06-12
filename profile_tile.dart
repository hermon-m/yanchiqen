import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const ProfileTile({Key? key, required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}