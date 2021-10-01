import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:identity/hexagon/entities/auth_state.dart';
import 'package:identity/identity.dart';
import 'package:identity/ui/screens/login/stores/login_store.dart';
import 'package:identity/ui/screens/login/widgets/login_form.dart';
import 'package:identity/ui/shared_widgets/centered_progress_indicator.dart';
import 'package:mobx/mobx.dart';

class LoginScreen extends StatefulWidget {
  static const navigator = NamedNavigator<void>("/login");

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginStore _loginStore = getIt<LoginStore>();
  late final List<ReactionDisposer> _disposers;

  @override
  void initState() {
    super.initState();
    _disposers = [
      reaction<Exception?>(
          (_) => _loginStore.authState.maybeWhen(
                error: (exception) => exception,
                orElse: () => null,
              ),
          _handleErrorMessage),
      when(
          (_) => _loginStore.authState.maybeWhen(
                success: (authState) => authState == AuthState.Authenticated,
                orElse: () => false,
              ),
          _navigate),
    ];
  }

  void _handleErrorMessage(Exception? exception) {
    if (exception == null) return;

    SnackBarUtils.createErrorMessage(
        message: exception.toString(), title: "Unable to login")
      ..show(context);
  }

  Future<void> _navigate() async {
    await getIt<IdentityRouter>().onLoginEvent(context);
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d.call());
    _loginStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
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
          Observer(
            builder: (_) => _loginStore.authState.maybeWhen(
              loading: () => CenteredProgressIndicator(),
              orElse: () => SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
