import 'package:cubivue_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

class UserProfileAvatar extends StatelessWidget {
  final User user;

  const UserProfileAvatar({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColorDark,
          border: Border.all(color: Colors.white, width: 8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(3, 4), // changes position of shadow
            ),
          ],
        ),
        width: 200,
        height: 200,
        child: user.imageUrl == null
            ? _UserInitials(userName: user.username)
            : Image.network(
                user.imageUrl!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    _UserInitials(userName: user.name),
              ),
      ),
    );
  }
}

class _UserInitials extends StatelessWidget {
  final String? userName;

  const _UserInitials({Key? key, this.userName = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _formattedUsername,
        style: TextStyle(
            color: Theme.of(context).primaryColorDark.byLuminance(),
            fontSize: 64),
      ),
    );
  }

  String get _formattedUsername {
    if (userName?.isEmpty == true) return "N/A";
    if (userName!.length < 2) return userName!;
    if (userName!.contains(" ")) {
      final userNames = userName!.split(" ");
      return "${userNames.first[0]}${userNames.last[0]}";
    }

    return userName![0];
  }
}
