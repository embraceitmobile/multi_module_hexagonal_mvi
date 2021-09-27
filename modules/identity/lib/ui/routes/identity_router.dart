import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/ui/screens/login/login_screen.dart';
import 'package:identity/ui/screens/profile/profile_screen.dart';
import 'package:injectable/injectable.dart';

@Singleton()

/// The router for the [identity] module
class IdentityRouter with IRouter {
  IdentityRouter({required this.onLoginEvent});

  /// The implementing app will define which screen to navigate to when the
  /// user is successfully loggedIn.
  /// A navigation event has been defined here, as the screen to navigate
  /// might be outside of this [identity] module.
  final ValueGetter<NamedNavigator> onLoginEvent;

  /// Defining all the routes that are handled by the [identity] module here.
  final Map<String, RouteBuilder> routes = {
    LoginScreen.navigator.route: (context, args) => const LoginScreen(),
    ProfileScreen.navigator.route: (context, args) => const ProfileScreen(),
  };
}
