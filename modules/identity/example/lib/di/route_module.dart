import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';
import 'package:identity/ui/shared_widgets/centered_progress_indicator.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RouteModule {
  RouteModule();

  @singleton
  IdentityRouter get identityRouter => IdentityRouter(
        onLoginEvent: (context, {args}) => UserEditProfileScreen.navigator
            .pushReplacement(context, args: args),
      );

  @singleton
  RouteHandler provideRouteHandler(IdentityRouter identityRouter) =>
      RouteHandler([identityRouter], root: RootScreen());
}

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CenteredProgressIndicator(),
    );
  }
}
