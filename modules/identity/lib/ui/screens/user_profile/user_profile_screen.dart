import 'package:core/core.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  static const navigator = NamedNavigator<void>("/user_profile");

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Profile Screen"),
    );
  }
}
