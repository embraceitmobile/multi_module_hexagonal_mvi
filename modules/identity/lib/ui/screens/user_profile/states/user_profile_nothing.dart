import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';
import 'package:identity/ui/screens/user_profile/widgets/error_screen.dart';

class UserProfileNothing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ErrorScreen(
      assetPath: "assets/images/img_no_result_found.png",
      title: "Nothing to show",
      body: "Unable to show user profile details. Please try again.",
      button: Button(
        text: "Refresh",
        onPress: () async {
          try {
            await getIt<UserReader>().activeUser;
          } catch (ex) {
            print(ex);
          }
        },
      ),
    );
  }
}
