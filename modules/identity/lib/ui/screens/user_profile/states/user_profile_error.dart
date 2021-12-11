import 'package:flutter/material.dart';

class UserProfileError extends StatelessWidget {
  final Exception error;

  const UserProfileError({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
