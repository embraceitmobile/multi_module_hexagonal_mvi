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
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  height: 360,
                  alignment: Alignment.topRight,
                  image: AssetImage(
                    "assets/images/img_login_cat_illustration.png",
                    package: "identity",
                  ),
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 32.0),
                  child: Text(
                    "Welcome!",
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0, bottom: 24),
                  child: Text(
                    "Please login to explore my humble abode!",
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.start,
                  ),
                ),
                LoginForm(),
              ],
            ),
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
