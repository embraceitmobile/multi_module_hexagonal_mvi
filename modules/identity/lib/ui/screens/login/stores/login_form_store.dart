import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'login_form_store.g.dart';

@lazySingleton
class LoginFormStore = _LoginFormStore with _$LoginFormStore;

abstract class _LoginFormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // constructor:---------------------------------------------------------------
  _LoginFormStore() {
    _disposers = [
      reaction((_) => userId, validateUserId),
      reaction((_) => password, validatePassword),
      when((_) => password.length >= 4, enablePasswordValidation),
    ];
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  // store variables:-----------------------------------------------------------
  @observable
  String userId = '';

  @observable
  String password = '';

  @observable
  bool userIdValidationEnabled = false;

  @observable
  bool passwordValidationEnabled = false;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin &&
      userId.isNotEmpty &&
      password.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) => userId = value;

  @action
  void setPassword(String value) => password = value;

  @action
  bool validateUserId(String value) {
    if (!userIdValidationEnabled) return true;

    if (value.isEmpty) {
      formErrorStore.userId = "Username cannot be empty";
      return false;
    } else {
      formErrorStore.userId = null;
      return true;
    }
  }

  @action
  bool validatePassword(String value) {
    if (!passwordValidationEnabled) return true;

    if (value.isEmpty) {
      formErrorStore.password = "Password can't be empty";
      return false;
    } else if (value.length < 4) {
      formErrorStore.password = "Password must be at-least 4 characters long";

      return false;
    } else {
      formErrorStore.password = null;
      return true;
    }
  }

  @action
  void enableUserIdValidation() => userIdValidationEnabled = true;

  @action
  void enablePasswordValidation() => passwordValidationEnabled = true;

  // general methods:-----------------------------------------------------------
  void validateLoginFields() {
    validatePassword(password);
    validateUserId(userId);
  }

  void dispose() {
    _disposers.forEach((d) => d.call());
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String? userId;

  @observable
  String? password;

  @computed
  bool get hasErrorsInLogin => userId != null || password != null;

  @computed
  bool get hasErrorsInUserId => userId != null;

  @computed
  bool get hasErrorInPassword => password != null;
}
