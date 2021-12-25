import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';
import 'package:identity/ui/screens/user_profile/widgets/error_screen.dart';

class UserProfileError extends StatelessWidget {
  final Exception error;

  const UserProfileError({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorScreen(
      assetPath: "assets/images/img_connection_failed.png",
      title: "Oops!!",
      body: "Something wrong with your connection, please try again.",
      button: Button(
        text: "Retry",
        onPress: () => getIt<UserReader>().user.catchError((error) {
          print(error);
        }),
      ),
    );
  }
}
