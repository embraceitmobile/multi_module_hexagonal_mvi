import 'package:core/core.dart';
import 'package:example/di/components/injection.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getIt<AuthReader>().isAuthenticated,
      initialData: null,
      builder: (context, authSnapshot) => MaterialApp(
        title: 'Identity Example',
        theme: ThemeData(primarySwatch: Colors.blue),
        onGenerateRoute: getIt<RouteHandler>().onGenerateRoute,
        initialRoute: RootScreen.navigator.route,
        home: _home(authSnapshot.data),
      ),
    );
  }

  Widget _home(bool? isAuthenticated) {
    if (isAuthenticated == null) return RootScreen();
    return isAuthenticated ? ProfileScreen() : LoginScreen();
  }
}
