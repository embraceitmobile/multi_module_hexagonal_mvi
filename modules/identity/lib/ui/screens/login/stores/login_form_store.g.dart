// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginFormStore on _LoginFormStore, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin =>
      (_$canLoginComputed ??= Computed<bool>(() => super.canLogin,
              name: '_LoginFormStore.canLogin'))
          .value;

  final _$userIdAtom = Atom(name: '_LoginFormStore.userId');

  @override
  String get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(String value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginFormStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$userIdValidationEnabledAtom =
      Atom(name: '_LoginFormStore.userIdValidationEnabled');

  @override
  bool get userIdValidationEnabled {
    _$userIdValidationEnabledAtom.reportRead();
    return super.userIdValidationEnabled;
  }

  @override
  set userIdValidationEnabled(bool value) {
    _$userIdValidationEnabledAtom
        .reportWrite(value, super.userIdValidationEnabled, () {
      super.userIdValidationEnabled = value;
    });
  }

  final _$passwordValidationEnabledAtom =
      Atom(name: '_LoginFormStore.passwordValidationEnabled');

  @override
  bool get passwordValidationEnabled {
    _$passwordValidationEnabledAtom.reportRead();
    return super.passwordValidationEnabled;
  }

  @override
  set passwordValidationEnabled(bool value) {
    _$passwordValidationEnabledAtom
        .reportWrite(value, super.passwordValidationEnabled, () {
      super.passwordValidationEnabled = value;
    });
  }

  final _$_LoginFormStoreActionController =
      ActionController(name: '_LoginFormStore');

  @override
  void setUserId(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.setUserId');
    try {
      return super.setUserId(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool validateUserId(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.validateUserId');
    try {
      return super.validateUserId(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool validatePassword(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void enableUserIdValidation() {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.enableUserIdValidation');
    try {
      return super.enableUserIdValidation();
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void enablePasswordValidation() {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.enablePasswordValidation');
    try {
      return super.enablePasswordValidation();
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userId: ${userId},
password: ${password},
userIdValidationEnabled: ${userIdValidationEnabled},
passwordValidationEnabled: ${passwordValidationEnabled},
canLogin: ${canLogin}
    ''';
  }
}

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool>? _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??= Computed<bool>(
          () => super.hasErrorsInLogin,
          name: '_FormErrorStore.hasErrorsInLogin'))
      .value;
  Computed<bool>? _$hasErrorsInUserIdComputed;

  @override
  bool get hasErrorsInUserId => (_$hasErrorsInUserIdComputed ??= Computed<bool>(
          () => super.hasErrorsInUserId,
          name: '_FormErrorStore.hasErrorsInUserId'))
      .value;
  Computed<bool>? _$hasErrorInPasswordComputed;

  @override
  bool get hasErrorInPassword => (_$hasErrorInPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInPassword,
              name: '_FormErrorStore.hasErrorInPassword'))
      .value;

  final _$userIdAtom = Atom(name: '_FormErrorStore.userId');

  @override
  String? get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(String? value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  final _$passwordAtom = Atom(name: '_FormErrorStore.password');

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  @override
  String toString() {
    return '''
userId: ${userId},
password: ${password},
hasErrorsInLogin: ${hasErrorsInLogin},
hasErrorsInUserId: ${hasErrorsInUserId},
hasErrorInPassword: ${hasErrorInPassword}
    ''';
  }
}
