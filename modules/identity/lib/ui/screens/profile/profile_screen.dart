import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const navigator = NamedNavigator<void>("/profile");

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Profile Screen"),
    );
  }
}
