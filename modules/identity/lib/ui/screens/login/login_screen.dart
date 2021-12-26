import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:identity/identity.dart';
import 'package:identity/ui/screens/login/widgets/login_form.dart';
import 'package:identity/ui/shared_widgets/auth_consumer.dart';

import 'stores/login_form_store.dart';

class LoginScreen extends StatefulWidget {
  static const navigator = NamedNavigator<void>("/login");

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: AuthConsumer(
        onAuthenticated: (context) async =>
            await getIt<IdentityRouter>().onLoginEvent(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "User Login",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    getIt<LoginFormStore>().dispose();
    super.dispose();
  }
}
