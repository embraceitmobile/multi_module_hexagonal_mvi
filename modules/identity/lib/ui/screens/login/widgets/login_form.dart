import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:identity/identity.dart';
import 'package:identity/ui/screens/login/stores/login_form_store.dart';
import 'package:identity/ui/shared_widgets/rounded_material_button.dart';
import 'package:identity/ui/shared_widgets/textfield_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  static const TAG = "LoginForm";

  late final LoginFormStore _loginFormStore = getIt<LoginFormStore>();
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: _loginFormStore.userId);
    _passwordController = TextEditingController(text: _loginFormStore.password);
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          userIdField,
          SizedBox(height: 18),
          passwordField,
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
          hasIcon: false,
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
          hasIcon: false,
          onTap: () {
            _loginFormStore.enableUserIdValidation();
            _loginFormStore.validateUserId(_loginFormStore.userId);
          },
          errorText: _loginFormStore.formErrorStore.password,
          onChanged: (value) => _loginFormStore.setPassword(value),
          onFieldSubmitted: (value) {
            if (_loginFormStore.canLogin) _login();
          },
        ),
      );

  Widget get loginButton => Observer(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 16.0),
          child: RoundedMaterialButton(
            text: 'LOGIN',
            onPressed: !_loginFormStore.canLogin
                ? null
                : () {
                    context.hideKeyboard();

                    if (_loginFormStore.canLogin) {
                      _login();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill in all fields'),
                          duration: Duration(seconds: 6),
                        ),
                      );
                    }
                  },
          ),
        ),
      );

  Future<void> _login() async {
    try {
      await getIt<AuthActions>()
          .login(_loginFormStore.userId, _loginFormStore.password);
    } catch (ex) {
      print("[$TAG][login] $ex");
    }
  }
}
