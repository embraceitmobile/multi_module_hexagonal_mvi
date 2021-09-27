import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

import 'di/components/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final _routeHandler = RouteHandler([
    IdentityRouter(
      onLoginEvent: (context, {args}) =>
          ProfileScreen.navigator.pushReplacement(context, args: args),
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Identity Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _routeHandler.onGenerateRoute,
      initialRoute: LoginScreen.navigator.route,
    );
  }
}
