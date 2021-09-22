import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:identity/hexagon/entities/auth_state.dart';
import 'package:identity/ui/screens/login/stores/login_store.dart';
import 'package:identity/ui/screens/login/widgets/login_form.dart';
import 'package:identity/ui/shared_widgets/centered_progress_indicator.dart';
import 'package:mobx/mobx.dart';

class LoginScreen extends StatefulWidget {
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

  void _navigate() {
    Future.microtask(() =>
        Navigator.of(context).pushNamedAndRemoveUntil("/home", (_) => false));
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d.call());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "User Login",
          style: Theme.of(context).textTheme.headline1,
        ),
        LoginForm(),
        Observer(
          builder: (_) => _loginStore.authState.maybeWhen(
            loading: () => CenteredProgressIndicator(),
            orElse: () => SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
