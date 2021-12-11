import 'package:flutter/material.dart';
import 'package:identity/identity.dart';
import 'package:identity/ui/screens/user_profile/widgets/user_profile_avatar.dart';

class UserProfileSuccess extends StatelessWidget {
  final User user;

  const UserProfileSuccess({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _UserProfileBody(user: user),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class _UserProfileBody extends StatelessWidget {
  final User user;

  const _UserProfileBody({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        UserProfileAvatar.medium(
          imageUrl: user.imageUrl,
          userName: user.username,
        ),
      ],
    );
  }
}
