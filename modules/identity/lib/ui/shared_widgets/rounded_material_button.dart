import 'package:flutter/material.dart';

class RoundedMaterialButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double radius;

  const RoundedMaterialButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.radius = 8.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      disabledColor: Theme.of(context).primaryColor.withOpacity(0.5),
      elevation: 3.0,
      disabledElevation: 0,
      child: Text(text),
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).primaryColor.byLuminance(),
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
