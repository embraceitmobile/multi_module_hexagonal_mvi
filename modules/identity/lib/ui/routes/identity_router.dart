import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/ui/screens/login/login_screen.dart';
import 'package:identity/ui/screens/user_edit_profile/user_edit_profile_screen.dart';
import 'package:identity/ui/screens/user_profile/user_profile_screen.dart';
import 'package:injectable/injectable.dart';

typedef RouteGetter<T> = Future<T> Function(BuildContext context,
    {Object? args});

@Singleton()

/// The router for the [identity] module
class IdentityRouter with IRouter {
  IdentityRouter({required this.onLoginEvent});

  /// The implementing app will define which screen to navigate to when the
  /// user is successfully loggedIn.
  /// A navigation event has been defined here, as the screen to navigate
  /// might be outside of this [identity] module. If the navigation screen is
  /// known then there is no need to define a navigation event.
  ///
  /// @params: [BuildContext] context, and [Object]? args
  final RouteGetter<void> onLoginEvent;

  /// Defining all the routes that are handled by the [identity] module here.
  final Map<String, RouteBuilder> routes = {
    LoginScreen.navigator.route: (context, args) => const LoginScreen(),
    UserProfileScreen.navigator.route: (context, args) =>
        const UserProfileScreen(),
    UserEditProfileScreen.navigator.route: (context, args) =>
        const UserEditProfileScreen(),
  };
}
