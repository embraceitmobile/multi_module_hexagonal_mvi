import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget with Screen<void> {
  static const navigator = NamedNavigator<void>("profile/");

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class Screen<T> {
  static const navigator = NamedNavigator<void>("profile/");
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
