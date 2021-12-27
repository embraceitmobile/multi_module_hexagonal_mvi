import 'package:flutter/material.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double radius;

  const RoundedOutlinedButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.radius = 8.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white70),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(width: 2, color: Theme.of(context).primaryColor),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .button
            ?.copyWith(color: Theme.of(context).primaryColor),
      ),
      onPressed: onPressed,
    );
  }
}

extension ColorUtil on Color? {
  Color byLuminance() {
    if (this == null) return Colors.black87;
    return this!.computeLuminance() > 0.4 ? Colors.black87 : Colors.white;
  }
}
