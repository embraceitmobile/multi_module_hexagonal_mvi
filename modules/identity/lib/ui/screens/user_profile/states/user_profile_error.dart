import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

class UserProfileError extends StatelessWidget {
  final Exception error;

  const UserProfileError({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    image: AssetImage(
                      "assets/images/img_connection_failed.png",
                      package: "identity",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              "Oops!!",
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 16),
            Text(
              "Something wrong with your connection, please try again.",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                try {
                  await getIt<UserReader>().activeUser;
                } catch (ex) {
                  print(ex);
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48.0, vertical: 12),
                child: Text(
                  "Retry",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(color: Colors.white, fontSize: 18),
                ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
