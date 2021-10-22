import 'package:flutter/material.dart';

class UserProfileUsernameTile extends StatelessWidget {
  final String username;

  const UserProfileUsernameTile({Key? key, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      child: Center(
        child: Text(
          username,
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
