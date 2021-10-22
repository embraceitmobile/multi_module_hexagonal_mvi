import 'package:flutter/material.dart';

class UserProfileAvatarTile extends StatelessWidget {
  final String? imageUrl;
  final ValueSetter<String> onNewImage;

  const UserProfileAvatarTile({
    Key? key,
    required this.onNewImage,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
