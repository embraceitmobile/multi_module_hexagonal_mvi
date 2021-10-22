import 'package:flutter/material.dart';

class UserProfileItemTile extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;

  const UserProfileItemTile({
    Key? key,
    this.controller,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: UnderlineInputBorder(),
      ),
    );
  }
}
