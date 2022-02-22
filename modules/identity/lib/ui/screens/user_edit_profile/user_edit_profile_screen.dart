import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

class UserEditProfileScreen extends StatefulWidget {
  static const navigator = NamedNavigator<User>("/user_edit_profile");

  const UserEditProfileScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<StatefulWidget> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text("Edit Profile"),
          ),
          body: Center(child: Text(widget.user.toString()))),
    );
  }
}
