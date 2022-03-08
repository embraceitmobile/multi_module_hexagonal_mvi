import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button {
  final String text;
  final VoidCallback onPress;

  const Button({required this.text, required this.onPress});
}

class ErrorScreen extends StatelessWidget {
  final String assetPath;
  final String title;
  final String body;
  final Button? button;

  const ErrorScreen(
      {Key? key,
      required this.assetPath,
      required this.title,
      required this.body,
      this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage(
                assetPath,
                package: "identity",
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
          SafeArea(
            child: Align(
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 8),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(height: 16),
                if (button != null)
                  ElevatedButton(
                    onPressed: button!.onPress,
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 48.0, vertical: 12),
                      child: Text(
                        button!.text,
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
                  ),
                SizedBox(height: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}
