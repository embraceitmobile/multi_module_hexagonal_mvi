import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/ui/shared_widgets/centered_progress_indicator.dart';

class RootScreen extends StatelessWidget {
  static const navigator = NamedNavigator<void>("/");

  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CenteredProgressIndicator(),
    );
  }
}
