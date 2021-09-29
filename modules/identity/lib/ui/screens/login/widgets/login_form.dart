import 'package:core/core.dart';
import 'package:cubivue_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:identity/ui/screens/login/stores/login_form_store.dart';
import 'package:identity/ui/screens/login/stores/login_store.dart';
import 'package:identity/ui/shared_widgets/textfield_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  static const TAG = "LoginForm";

  late final LoginFormStore _loginFormStore = getIt<LoginFormStore>();
  late final LoginStore _loginStore = getIt<LoginStore>();

  late final TextEditingController _userNameController =
      TextEditingController();

  late final TextEditingController _passwordController =
      TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();

    _loginFormStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          userIdField,
          SizedBox(height: 12),
          passwordField,
          SizedBox(height: 24),
          loginButton,
        ],
      ),
    );
  }

  Widget get userIdField => Observer(
        builder: (_) => TextFieldWidget(
          textController: _userNameController,
          enableSuggestions: false,
          autocorrect: false,
          hint: "Username",
          inputType: TextInputType.visiblePassword,
          // TextInputType.visiblePassword is used for hiding suggestions in keyboard,
          // as enableSuggestions = false, and autocorrect = false do not work on all devices
          isIcon: false,
          inputAction: TextInputAction.next,
          onChanged: (value) => _loginFormStore.setUserId(value),
          errorText: _loginFormStore.formErrorStore.userId,
        ),
      );

  Widget get passwordField => Observer(
        builder: (_) => TextFieldWidget(
          textController: _passwordController,
          hint: "Password",
          isObscure: true,
          inputType: TextInputType.text,
          isIcon: false,
          onTap: () {
            _loginFormStore.enableUserIdValidation();
            _loginFormStore.validateUserId(_loginFormStore.userId);
          },
          errorText: _loginFormStore.formErrorStore.password,
          onChanged: (value) => _loginFormStore.setPassword(value),
          onFieldSubmitted: (value) {
            if (_loginFormStore.canLogin)
              _loginStore.login(
                _loginFormStore.userId,
                _loginFormStore.password,
              );
          },
        ),
      );

  Widget get loginButton => Observer(
        builder: (context) => MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3.0),
            ),
          ),
          disabledColor: Theme.of(context).primaryColor.withOpacity(0.5),
          child: Text('LOGIN'),
          color: Theme.of(context).primaryColor,
          textColor: Theme.of(context).primaryColor.byLuminance(),
          onPressed: !_loginFormStore.canLogin
              ? null
              : () {
                  DeviceUtils.hideKeyboard(context);
                  if (_loginFormStore.canLogin) {
                    _loginStore.login(
                      _loginFormStore.userId,
                      _loginFormStore.password,
                    );
                  } else {
                    SnackBarUtils.createErrorMessage(
                        message: 'Please fill in all fields', title: 'Error')
                      ..show(context);
                  }
                },
        ),
      );
}
