import 'package:flutter/widgets.dart';

extension BuildContextExt on BuildContext {
  void hideKeyboard() => FocusScope.of(this).unfocus();
}