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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Identity Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: getIt<RouteHandler>().onGenerateRoute,
      initialRoute: LoginScreen.navigator.route,
    );
  }
}
